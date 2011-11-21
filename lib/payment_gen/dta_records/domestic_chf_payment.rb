class PaymentGen::DTARecords::DomesticCHFPayment < PaymentGen::DTARecords::Base

  def record
    @record ||= segment1 + segment2 + segment3 + segment4 + segment5
  end

  def transaction_type
    '827'
  end

  def payment_type
    '0'
  end

  def beneficiarys_bank_account_number
    "/C/#{@data[:beneficiarys_bank_account_number]}".ljust(30)
  end

  def end_beneficiary_address
    end_beneficiary_address_line1 + end_beneficiary_address_line2 + end_beneficiary_address_line3 + end_beneficiary_address_line4
  end

  def end_beneficiary_address_line1
    @data[:end_beneficiary_address_line1].to_s.ljust(24)
  end

  def end_beneficiary_address_line2
    @data[:end_beneficiary_address_line2].to_s.ljust(24)
  end

  def end_beneficiary_address_line3
    @data[:end_beneficiary_address_line3].to_s.ljust(24)
  end

  def end_beneficiary_address_line4
    @data[:end_beneficiary_address_line4].to_s.ljust(24)
  end

  def end_beneficiarys_bank_account_number
    return if @data[:end_beneficiarys_bank_account_number].nil? || @data[:end_beneficiarys_bank_account_number].empty?
    "/C/#{@data[:end_beneficiarys_bank_account_number]}".ljust(30)
  end
  protected

  def build_segment1
   super + reference_number + account_to_be_debited + payment_amount + reserve_field(14)
  end

  def build_segment2
     super + ordering_partys_address + posting_text(30)
  end

  def build_segment3
    super + beneficiarys_bank_account_number + beneficiary_address
  end

  def build_segment4
    super + reason_for_payment_message(28) + reserve_field(14)
  end

  def build_segment5
    return '' unless end_beneficiarys_bank_account_number
    super + end_beneficiarys_bank_account_number + end_beneficiary_address
  end
end
