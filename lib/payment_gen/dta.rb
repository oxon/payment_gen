require 'set'
require 'bigdecimal'

module PaymentGen
  class DTA
    attr_reader :records

    def self.generate(transaktions_nummer)
      dta = PaymentGen::DTA.new(transaktions_nummer)
      yield dta
      dta.finish
      dta
    end

    def self.create(transaktions_nummer, path, &block)
      dta = generate(transaktions_nummer, &block)
      dta.write_file(path)
      dta
    end

    def initialize(transaction_number = rand(100000000000).to_s)
      @transaction_number = transaction_number.to_s
      @records = Set.new
    end

    def write_file(path)
      File.open(path,"w") do |file|
        write_to(file)
      end
    end

    def write_to(io)
      raise 'the DTA must be finished before you can write it.' unless @finished
      @records.each{|record| io.print record.to_dta}
    end

    def total
      @records.inject(BigDecimal.new('0.0')) do |sum, record|
        sum + BigDecimal.new(record.amount.to_s)
      end.round(3)
    end

    def <<(record)
      ensure_not_finished!
      record.transaction_number = @transaction_number
      @records << record
    end

    def finish
      ensure_not_finished!
      raise 'you need to add records before finishing the DTA!' if @records.empty?
      @finished = true
      @records << build_total_record
      recalculate_entry_sequence_numbers
    end

    private

    def ensure_not_finished!
      raise 'the DTA has already been finished!' if @finished
    end

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
