require 'set'

module PaymentGen
  class DTA
    attr_reader :records

    def initialize(transaction_number = rand(100000000000).to_s)
      @transaction_number = transaction_number.to_s
      @records = SortedSet.new
    end

    def write_file(path)
      File.open(path,"w") do |file|
        write_to(file)
      end
    end

    def write_to(io)
      @records.each{|record| io.puts record.to_dta}
      io.puts build_total_record.to_dta
    end

    def total
      @records.inject(0) do |sum, record|
        sum + record.amount.to_f
      end
    end

    def <<(record)
      record.transaction_number = @transaction_number
      @records << record
      recalculate_entry_sequence_numbers
    end

    private

    def recalculate_entry_sequence_numbers
      start = 1
      @records.each do |record|
        record.entry_sequence_number = start
        start += 1
      end
    end

    def build_total_record
      Payments::TotalRecord.new(:total_amount => total,
                                :data_file_sender_identification => @records.first.data_file_sender_identification)
    end

  end
end
