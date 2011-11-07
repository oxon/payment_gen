module PaymentGen
  class EZAG

    attr_reader :records

    def self.generate
      ezag = PaymentGen::EZAG.new
      yield ezag
      ezag
    end

    def initialize
      @records = []
    end

    def write_to(io)
      @records.each{|record| io.puts record.to_s}
    end

    def <<(record)
      @records << record
    end

  end
end
