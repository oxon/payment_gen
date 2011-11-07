require "payment_gen/version"

require 'payment_gen/payment_sorting'
require 'payment_gen/character_conversion'
require "payment_gen/payments"
require 'payment_gen/dta'

module PaymentGen

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

end
