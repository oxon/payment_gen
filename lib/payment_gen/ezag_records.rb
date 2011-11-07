require 'payment_gen/ezag_records/base'

module PaymentGen
  module EZAGRecords
    autoload :HeadRecord, 'payment_gen/ezag_records/head_record'
    autoload :DomesticPostAccountRecord, 'payment_gen/ezag_records/domestic_post_account_record'
    autoload :TotalRecord, 'payment_gen/ezag_records/total_record'
  end
end
