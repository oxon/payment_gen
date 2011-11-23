# -*- coding: utf-8 -*-
require 'spec_helper'

describe PaymentGen::DTARecords::Base do

  let(:too_long_text) { 'I am way to long to fit in this line of the beneficiary adress' }

  describe "it uses a minimal character set" do
    subject { PaymentGen::DTARecords::Base.new(:data_file_sender_identification => 'ÄöÜ') }

    it "uses ISO-8859-1 for internal strings" do
      subject.data_file_sender_identification.encoding.name.should == "ISO-8859-1"
    end

    it "replaces characters according to the DTA-specification" do
      subject.data_file_sender_identification.should == "AEoeUE"
    end

    it "only works with strings internally" do
      record = PaymentGen::DTARecords::Base.new(:payment_amount => 12.5)
      record.amount.should == '12.5'
    end
  end

  describe "beneficiary_address" do
    it "trims beneficiary_address_line1, when it exceedes the maximum length" do
      record = PaymentGen::DTARecords::Base.new(:beneficiary_address_line1 => too_long_text)
      record.beneficiary_address_line1(20).should == 'I am way to long to '
    end

    it "trims beneficiary_address_line2, when it exceedes the maximum length" do
      record = PaymentGen::DTARecords::Base.new(:beneficiary_address_line2 => too_long_text)
      record.beneficiary_address_line2(20).should == 'I am way to long to '
    end

    it "trims beneficiary_address_line3, when it exceedes the maximum length" do
      record = PaymentGen::DTARecords::Base.new(:beneficiary_address_line3 => too_long_text)
      record.beneficiary_address_line3(20).should == 'I am way to long to '
    end

    it "trims beneficiary_address_line4, when it exceedes the maximum length" do
      record = PaymentGen::DTARecords::Base.new(:beneficiary_address_line4 => too_long_text)
      record.beneficiary_address_line4(20).should == 'I am way to long to '
    end
  end

  describe "ordering_partys_address" do
    it "trims ordering_partys_address_line1, when it exceedes the maximum length" do
      record = PaymentGen::DTARecords::Base.new(:ordering_partys_address_line1 => too_long_text)
      record.ordering_partys_address_line1(20).should == 'I am way to long to '
    end

    it "trims ordering_partys_address_line2, when it exceedes the maximum length" do
      record = PaymentGen::DTARecords::Base.new(:ordering_partys_address_line2 => too_long_text)
      record.ordering_partys_address_line2(20).should == 'I am way to long to '
    end

    it "trims ordering_partys_address_line3, when it exceedes the maximum length" do
      record = PaymentGen::DTARecords::Base.new(:ordering_partys_address_line3 => too_long_text)
      record.ordering_partys_address_line3(20).should == 'I am way to long to '
    end

    it "trims ordering_partys_address_line4, when it exceedes the maximum length" do
      record = PaymentGen::DTARecords::Base.new(:ordering_partys_address_line4 => too_long_text)
      record.ordering_partys_address_line4(20).should == 'I am way to long to '
    end
  end

  describe "reason for payment message" do
    it "fills with spaces" do
      record = PaymentGen::DTARecords::Base.new(:reason_for_payment_message_line1 => 'line 1',
                                                :reason_for_payment_message_line2 => 'line 2',
                                                :reason_for_payment_message_line3 => 'line 3',
                                                :reason_for_payment_message_line4 => 'line 4')
      record.reason_for_payment_message(10).should == 'line 1    line 2    line 3    line 4    '
    end

    it "trims, when the maximum length is exceeded" do
      record = PaymentGen::DTARecords::Base.new(:reason_for_payment_message_line1 => 'this-is-to-long',
                                                :reason_for_payment_message_line2 => 'this-is-to-long',
                                                :reason_for_payment_message_line3 => 'this-is-to-long',
                                                :reason_for_payment_message_line4 => 'this-is-to-long')
      record.reason_for_payment_message(7).should == 'this-isthis-isthis-isthis-is'
    end
  end

  it "fills the posting text with spaces" do
    record = PaymentGen::DTARecords::Base.new(:posting_text => 'Invoice 123')
    record.posting_text(50).should == "Invoice 123                                       "
  end

end
