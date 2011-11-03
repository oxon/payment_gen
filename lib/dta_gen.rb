require "dta_gen/version"

require 'dta_gen/payment_sorting'
require 'dta_gen/character_conversion'
require "dta_gen/payments"
require 'dta_gen/dta'

module DtaGen

  def self.generate(transaktions_nummer)
    dta = DtaGen::DTA.new(transaktions_nummer)
    yield dta
    dta
  end

  def self.create(transaktions_nummer, path, &block)
    dta = generate(transaktions_nummer, &block)
    dta.write_file(path)
    dta
  end

end
