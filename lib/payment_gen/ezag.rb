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
    end

    def <<(record)
      @records << record
    end

    def head_record
      EZAGRecords::HeadRecord.new @default_attributes
    end

  end
end
