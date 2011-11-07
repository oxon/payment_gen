module PaymentGen
  class EZAG

    attr_reader :records

    def self.generate
      ezag = PaymentGen::EZAG.new
      yield ezag
      ezag
    end

    def self.create(path, &block)
      ezag = generate(&block)
      ezag.write_file(path)
      ezag
    end

    def initialize
      @records = []
    end

    def write_file(path)
      File.open(path,"w") do |file|
        write_to(file)
      end
    end

    def write_to(io)
      @records.each{|record| io.puts record.to_s}
    end

    def <<(record)
      @records << record
    end

  end
end
