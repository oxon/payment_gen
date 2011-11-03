require "dta_gen/version"

require 'dta_gen/payment_sorting'
require 'dta_gen/character_conversion'
require "dta_gen/payments"
require 'dta_gen/dta'

module DtaGen
  def self.create(path)
    dta = DtaGen::DTA.new
    yield dta
    dta.write_file(path)
    dta
  end
end
