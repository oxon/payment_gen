# -*- coding: utf-8 -*-

class PaymentFactory
  def self.create_payment(type, attributes = {})
    send("create_#{type.to_s}_payment",attributes)
  end
  def self.create_esr_payment(attributes = {})
    default_attributes = {
      :requested_processing_date => Date.today.strftime('%y%m%d'),
      :payers_clearing_number => '254',
      :account_to_be_debited => '10235678',
      :payment_amount => '3949.75',
      :ordering_party_bank_clearing_number => '253'
    }.merge(attributes)
    DtaGen::Payments::ESRPayment.new(build_attributes(default_attributes))
  end

  def self.create_domestic_chf_payment(attributes = {})
    default_attributes = {
      :requested_processing_date => Date.today.strftime('%y%m%d'),
    }.merge(attributes)
    DtaGen::Payments::DomesticCHFPayment.new(build_attributes(default_attributes))
  end

  def self.create_total_payment(attributes = {})
    default_attributes = {
      :data_file_sender_identification => 'PAYDT',
      :total_amount => 233.451,
    }.merge(attributes)
    DtaGen::Payments::TotalRecord.new(default_attributes)
  end
  class << self
    alias :create_total_record :create_total_payment
  end

  private

  def self.build_attributes(attributes = {})
    {
      :data_file_sender_identification => 'PAYDT',
      :payment_amount_currency         => 'CHF',
      :issuer_identification           => 'ABC01',
      :transaction_number              => rand(100000000000).to_s,
      :output_sequence_number          => 1,
      :payment_amount_value_date => Date.today.strftime('%y%m%d')
    }.merge(attributes)
  end
end
