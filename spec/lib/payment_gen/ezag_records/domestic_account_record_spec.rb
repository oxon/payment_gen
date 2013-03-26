# -*- coding: utf-8 -*-
require 'spec_helper'

describe PaymentGen::EZAGRecords::DomesticAccountRecord do
  it "should set the source currency" do
    EZAGFactory.create_domestic_post_account_record(:source_currency => 'CHF').source_currency.should == 'CHF'
  end

  it "should set payment amount" do
    EZAGFactory.create_domestic_post_account_record(:payment_amount => 9847.80).payment_amount.should == '0000000984780'
  end

  it "should set the target currency" do
    EZAGFactory.create_domestic_post_account_record(:target_currency => 'CHF').target_currency.should == 'CHF'
  end

  it "should set land code" do
    EZAGFactory.create_domestic_post_account_record(:land_code => 'CH').land_code.should == 'CH'
  end

  describe "#receiver_account_number" do
    it "should set the account number of the receiver" do
      EZAGFactory.create_domestic_post_account_record(:receiver_account_number => '38-847394-5').receiver_account_number.should == '388473945'
    end

    it "adds spaces up to 9 characters" do
      EZAGFactory.create_domestic_post_account_record(:receiver_account_number => '38-8394-5').receiver_account_number.should == '3883945  '
    end
  end

  describe "#end_beneficiary_account_number" do
    it "should set the account number of the end beneficiary" do
      EZAGFactory.create_domestic_post_account_record(:end_beneficiary_account_number => 'CH8774658193857463527').end_beneficiary_account_number.should == "CH8774658193857463527#{' ' * 14}"
    end

    it "is not required" do
      EZAGFactory.create_domestic_post_account_record(:end_beneficiary_account_number => nil).end_beneficiary_account_number.should == "#{' ' * 35}"
    end
  end

  it "should set the receivers name" do
    EZAGFactory.create_domestic_post_account_record(:receiver_name => 'Ueli Müller').receiver_name.should == "Ueli Müller#{' ' * 24}"
  end

  it "should set the additional identification of the receiver" do
    EZAGFactory.create_domestic_post_account_record(:additional_identification => 'z.H. Iris Oppliger').additional_identification.should == "z.H. Iris Oppliger#{' ' * 17}"
  end

  it "should set the street of the receivers address" do
    EZAGFactory.create_domestic_post_account_record(:receiver_street => 'Milchstrasse 38').receiver_street.should == "Milchstrasse 38#{' ' * 20}"
  end

  it "should set the receivers zip code" do
    EZAGFactory.create_domestic_post_account_record(:receiver_zip_code => '8734').receiver_zip_code.should == '8734      '
  end

  it "should set the receivers city" do
    EZAGFactory.create_domestic_post_account_record(:receiver_city => 'Bern').receiver_city.should == "Bern#{' ' * 21}"
  end
end
