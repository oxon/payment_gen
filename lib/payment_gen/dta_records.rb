require 'payment_gen/dta_records/base'
require "payment_gen/dta_records/total_record"

module PaymentGen
  module DTARecords
    autoload :ESRPayment, 'payment_gen/dta_records/esr_payment'
    autoload :DomesticCHFPayment, 'payment_gen/dta_records/domestic_chf_payment'
  end
end
