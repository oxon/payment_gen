require 'payment_gen/records/base'
require "payment_gen/records/total_record"

module PaymentGen
  module Records
    autoload :ESRPayment, 'payment_gen/records/esr_payment'
    autoload :DomesticCHFPayment, 'payment_gen/records/domestic_chf_payment'
  end
end
