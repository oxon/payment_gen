module PaymentGen
  class EZAG

    attr_reader :records, :default_attributes

    def self.generate(attributes = {})
      ezag = PaymentGen::EZAG.new(attributes)
      yield ezag
      ezag
    end

    def self.create(path, attributes = {}, &block)
      ezag = generate(attributes, &block)
      ezag.write_file(path)
      ezag
    end

    def initialize(default_attributes = {})
      @records = []
      @default_attributes = default_attributes
    end

    def write_file(path)
      File.open(path,"w") do |file|
        write_to(file)
      end
    end

    def write_to(io)
      io.puts head_record.to_s
      @records.each{|record| io.puts record.to_s}
      io.puts total_record.to_s
    end

    def <<(record)
      @records << record
      recalculate_transaction_numbers
    end

    private

    def recalculate_transaction_numbers
      start = 1
      @records.each do |record|
        record.transaction_number = start
        start += 1
      end
    end

    def totals
      @records.inject({}) do |sums, record|
        entry = (sums[record.source_currency] || {})
        entry[:total] = (entry[:total] || 0) + record.native_payment_amount
        entry[:transactions] = (entry[:transactions] || 0) + 1
        sums[record.source_currency] = entry
        sums
      end
    end

    def head_record
      EZAGRecords::HeadRecord.new @default_attributes
    end

    def total_record
      EZAGRecords::TotalRecord.new @default_attributes.merge(:totals => totals)
    end

  end
end
