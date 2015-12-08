# -*- coding: utf-8 -*-
require 'spec_helper'

describe PaymentGen::EZAGRecords::DomesticBankAccountRecord do

  describe "control section" do
    it "should set the transaction type to 27" do
      EZAGFactory.create_domestic_bank_account_record.transaction_type.should == '27'
    end
  end

  it "should set the receivers bank" do
    EZAGFactory.create_domestic_bank_account_record(:receiver_bank => 'Zürcher Kantonalbank').receiver_bank.should == "Zürcher Kantonalbank#{' ' * 15}"
  end

  it "should set the receivers bank description" do
    EZAGFactory.create_domestic_bank_account_record(:receiver_bank_description => 'c/o Guido Bernasconi').receiver_bank_description.should == "c/o Guido Bernasconi#{' ' * 15}"
  end

  it "should set the receivers bank street" do
    EZAGFactory.create_domestic_bank_account_record(:receiver_bank_street => 'Waldstätterstrasse 15').receiver_bank_street.should == "Waldstätterstrasse 15#{' ' * 14}"
  end

  it "should set the receivers bank zip code" do
    EZAGFactory.create_domestic_bank_account_record(:receiver_bank_zip_code => '3014').receiver_bank_zip_code.should == "3014#{' ' * 6}"
  end

  it "should set the receivers bank city" do
    EZAGFactory.create_domestic_bank_account_record(:receiver_bank_city => 'Bern').receiver_bank_city.should == "Bern#{' ' * 21}"
  end

  describe "to_s" do
    it "returns the domestic post account record" do
      record = EZAGFactory.create_domestic_bank_account_record(:due_date => '24.9.1928', :account_number => '48-387493-2', :source_currency => 'CHF', :payment_amount => 803.50, :target_currency => 'CHF', :land_code => 'CH', :end_beneficiary_account_number => 'CH8794857239482758715', :receiver_name => 'Spöri Enterprises', :additional_identification => 'z.H. Fritz Knall', :receiver_street => 'Packweg 9', :receiver_zip_code => '1843', :receiver_city => 'Genf', :receiver_bank => 'UBS AG', :receiver_bank_description => 'c/o Petra Huber', :receiver_bank_zip_code => '8010', :receiver_bank_city => 'Zürich')
      record.transaction_number = 1
      record.to_s.should == '03628092400000148387493248387493201270000010000000CHF0000000080350 CHFCH838938235      CH8794857239482758715              UBS AG                             c/o Petra Huber                                                       8010      Zürich                   Spöri Enterprises                  z.H. Fritz Knall                   Packweg 9                          1843      Genf                                                                                                                                                                                                                                                                                                                               '
    end
  end

end
