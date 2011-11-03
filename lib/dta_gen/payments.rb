require 'dta_gen/payments/base'
require "dta_gen/payments/total_record"

module DtaGen
  module Payments
    autoload :ESRPayment, 'dta_gen/payments/esr_payment'
    autoload :DomesticCHFPayment, 'dta_gen/payments/domestic_chf_payment'
  end
end
