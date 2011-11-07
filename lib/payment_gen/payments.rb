require 'payment_gen/payments/base'
require "payment_gen/payments/total_record"

module PaymentGen
  module Payments
    autoload :ESRPayment, 'payment_gen/payments/esr_payment'
    autoload :DomesticCHFPayment, 'payment_gen/payments/domestic_chf_payment'
  end
end
