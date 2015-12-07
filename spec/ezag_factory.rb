class EZAGFactory

  def self.create_record(attributes = {})
    PaymentGen::EZAGRecords::Base.new(attributes)
  end

  def self.create_head_record(attributes = {})
    PaymentGen::EZAGRecords::HeadRecord.new(attributes)
  end

  def self.create_domestic_bank_account_record(attributes = {})
    default_attributes = {
      :payment_amount => 83.5,
      :receiver_account_number => '83-893823-5',
      :receiver_name => 'Ueli',
      :source_currency => 'CHF',
      :target_currency => 'CHF',
      :land_code => 'CH'
    }.merge attributes
    PaymentGen::EZAGRecords::DomesticBankAccountRecord.new(build_attributes(default_attributes))
  end

  def self.create_domestic_post_account_record(attributes = {})
    default_attributes = {
      :payment_amount => 83.5,
      :receiver_account_number => '83-893823-5',
      :receiver_name => 'Ueli',
      :source_currency => 'CHF',
      :target_currency => 'CHF',
      :land_code => 'CH'
    }.merge attributes
    PaymentGen::EZAGRecords::DomesticPostAccountRecord.new(build_attributes(default_attributes))
  end

  def self.create_domestic_reference_number_record(attributes = {})
    default_attributes = {
      :payment_amount => 83.5,
      :receiver_account_number => '83-893823-5',
      :receiver_name => 'Ueli',
      :source_currency => 'CHF',
      :target_currency => 'CHF',
      :land_code => 'CH',
      :reference_number => '99999999999999999999999999P',
    }.merge attributes
    PaymentGen::EZAGRecords::DomesticReferenceNumberRecord.new(build_attributes(default_attributes))
  end

  def self.create_total_record(attributes = {})
    PaymentGen::EZAGRecords::TotalRecord.new(attributes)
  end

  def self.build_attributes(attributes)
    {
      :account_number => '84-284732-2'
    }.merge attributes
  end

end
