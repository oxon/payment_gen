require 'set'
require 'bigdecimal'

module PaymentGen
  class DTA
    attr_reader :records

    def self.generate(transaktions_nummer)
      dta = PaymentGen::DTA.new(transaktions_nummer)
      yield dta
      dta
    end

    def self.create(transaktions_nummer, path, &block)
      dta = generate(transaktions_nummer, &block)
      dta.write_file(path)
      dta
    end

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
        sum + BigDecimal.new(record.amount.to_s)
      end.round(3)
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
      DTARecords::TotalRecord.new(:total_amount => total.to_s('F'),
                                  :data_file_sender_identification => @records.first.data_file_sender_identification)
    end

  end
end
