# -*- coding: utf-8 -*-
require 'spec_helper'

describe PaymentGen::EZAGRecords::DomesticReferenceNumberRecord do

  describe "control section" do
    it "should set the transaction type to 28" do
      EZAGFactory.create_domestic_reference_number_record.transaction_type.should == '28'
    end
  end

  describe "to_s" do
    it "returns the domestic post account record" do
      record = EZAGFactory.create_domestic_reference_number_record(:due_date => '24.9.1928', :account_number => '48-387493-2', :source_currency => 'CHF', :payment_amount => 803.50, :target_currency => 'CHF', :land_code => 'CH', :receiver_account_number => '95-847392-9', :end_beneficiary_account_number => 'CH8794857239482758715', :receiver_name => 'Spöri Enterprises', :additional_identification => 'z.H. Fritz Knall', :receiver_street => 'Packweg 9', :receiver_zip_code => '1843', :receiver_city => 'Genf', :message_1 => 'V-2011.8796 CD Uster ZH', :message_2 => 'Konto 61160 Fr. 104.00', :message_3 => 'Konto 60060 Fr. 104.00', :message_4 => 'Konto 68000 Fr. 117.00')
      record.transaction_number = 1
      record.to_s.should == ("03628092400000148387493248387493201280000010000000CHF0000000080350 CHFCH  95847392999999999999999999999999999PSpöri Enterprises                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ")
    end
  end
end
