require "payment_gen/version"

require 'payment_gen/payment_sorting'
require 'payment_gen/character_conversion'
require "payment_gen/payments"
require 'payment_gen/dta'

module PaymentGen

  def self.dta
    PaymentGen::DTA
  end

end
