require 'spec_helper'

describe PaymentGen::DTA do

  it "should set the transaction_number for any record added" do
    file = PaymentGen::DTA.new("00123478901")
    file << PaymentFactory.create_esr_payment
    file.records.first.transaction_number.should == "00123478901"
  end

  it "should calculate the entry_sequence_number" do
    file = PaymentGen::DTA.new
    file << PaymentFactory.create_esr_payment
    file << PaymentFactory.create_esr_payment

    file.records.to_a.first.entry_sequence_number.should == "00001"
    file.records.to_a[1].entry_sequence_number.should == "00002"
  end

  it "should calculate the total amount" do
    file = PaymentGen::DTA.new
    file << PaymentFactory.create_esr_payment(:payment_amount => 420.50)
    file << PaymentFactory.create_esr_payment(:payment_amount => 320.20)
    file.total.should == (420.50 + 320.20)
  end

  describe PaymentGen::DTA, "file records" do
    before(:each) do
      @record1 = PaymentFactory.create_esr_payment(:payment_amount => 2222.22)
      @record2 = PaymentFactory.create_esr_payment(:payment_amount => 4444.44)
      stream = StringIO.new
      @dta_file = PaymentGen::DTA.new
      @dta_file << @record1
      @dta_file << @record2
      @dta_file.write_to(stream)
      stream.rewind
      @file_records = stream.readlines
    end

    it "should add the records to the file in dta format" do
      @file_records.should include(@record2.to_dta + "\n")
      @file_records.should include(@record2.to_dta + "\n")
    end

    it "should add a total record" do
      @file_records.last.should include(PaymentFactory.create_total_record(:total_amount => 6666.66).to_dta)
    end
  end

  describe PaymentGen::DTA, "record sorting" do
    before(:each) do
      @record1 = PaymentFactory.create_esr_payment(:requested_processing_date  => "091027", :issuer_identification => "AAAAA")
      @record2 = PaymentFactory.create_esr_payment(:requested_processing_date  => "091026",:issuer_identification => "BBBBB")
      @record3 = PaymentFactory.create_esr_payment(:requested_processing_date  => "091026",:issuer_identification => "CCCCC")
      @record4 = PaymentFactory.create_esr_payment(:requested_processing_date  => "091028",:issuer_identification => "AAAAA")
      @dta_file = PaymentGen::DTA.new
      @dta_file << @record1
      @dta_file << @record2
      @dta_file << @record3
      @dta_file << @record4
    end

    it "should add all records to it" do
      @dta_file.records.size.should equal(4)
    end

    it "should sort the records" do
      @dta_file.records.to_a.should == [@record1, @record2,@record3, @record4].sort
    end
  end
end