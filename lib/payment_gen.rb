require "payment_gen/version"

require 'payment_gen/payment_sorting'
require 'payment_gen/character_conversion'
require "payment_gen/dta_records"
require 'payment_gen/dta'
require "payment_gen/ezag_records"
require 'payment_gen/ezag'

module PaymentGen

  def self.dta
    PaymentGen::DTA
  end

end
