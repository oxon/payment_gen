# -*- coding: utf-8 -*-
require 'spec_helper'

describe PaymentGen::Payments::Base do

  let(:too_long_text) { 'I am way to long to fit in this line of the beneficiary adress' }

  describe "it uses a minimal character set" do
    subject { PaymentGen::Payments::Base.new(:data_file_sender_identification => 'ÄöÜ') }

    it "uses ISO-8859-1 for internal strings" do
      subject.data_file_sender_identification.encoding.name.should == "ISO-8859-1"
    end

    it "replaces characters according to the DTA-specification" do
      subject.data_file_sender_identification.should == "AEoeUE"
    end

    it "only works with strings internally" do
      record = PaymentGen::Payments::Base.new(:payment_amount => 12.5)
      record.amount.should == '12.5'
    end
  end

  describe "beneficiary_address" do
    it "trims beneficiary_address_line1, when it exceedes the maximum length" do
      record = PaymentGen::Payments::Base.new(:beneficiary_address_line1 => too_long_text)
      record.beneficiary_address_line1(20).should == 'I am way to long to '
    end

    it "trims beneficiary_address_line2, when it exceedes the maximum length" do
      record = PaymentGen::Payments::Base.new(:beneficiary_address_line2 => too_long_text)
      record.beneficiary_address_line2(20).should == 'I am way to long to '
    end

    it "trims beneficiary_address_line3, when it exceedes the maximum length" do
      record = PaymentGen::Payments::Base.new(:beneficiary_address_line3 => too_long_text)
      record.beneficiary_address_line3(20).should == 'I am way to long to '
    end

    it "trims beneficiary_address_line4, when it exceedes the maximum length" do
      record = PaymentGen::Payments::Base.new(:beneficiary_address_line4 => too_long_text)
      record.beneficiary_address_line4(20).should == 'I am way to long to '
    end
  end

  describe "ordering_partys_address" do
    it "trims ordering_partys_address_line1, when it exceedes the maximum length" do
      record = PaymentGen::Payments::Base.new(:ordering_partys_address_line1 => too_long_text)
      record.ordering_partys_address_line1(20).should == 'I am way to long to '
    end

    it "trims ordering_partys_address_line2, when it exceedes the maximum length" do
      record = PaymentGen::Payments::Base.new(:ordering_partys_address_line2 => too_long_text)
      record.ordering_partys_address_line2(20).should == 'I am way to long to '
    end

    it "trims ordering_partys_address_line3, when it exceedes the maximum length" do
      record = PaymentGen::Payments::Base.new(:ordering_partys_address_line3 => too_long_text)
      record.ordering_partys_address_line3(20).should == 'I am way to long to '
    end

    it "trims ordering_partys_address_line4, when it exceedes the maximum length" do
      record = PaymentGen::Payments::Base.new(:ordering_partys_address_line4 => too_long_text)
      record.ordering_partys_address_line4(20).should == 'I am way to long to '
    end
  end

end
