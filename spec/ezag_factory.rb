class EZAGFactory

  def self.create_record(attributes = {})
    PaymentGen::EZAGRecords::Base.new(attributes)
  end

  def self.create_head_record(attributes = {})
    PaymentGen::EZAGRecords::HeadRecord.new(attributes)
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

  def self.build_attributes(attributes)
    {
      :account_number => '84-284732-2'
    }.merge attributes
  end

end
