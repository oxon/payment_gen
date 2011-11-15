require 'spec_helper'

describe PaymentGen::DTA do

  let(:transaction_number) { '12345' }
  let(:dta_file_path) { File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'tmp', 'payments.dta')) }

  it "should generate a DTA object" do
    result = PaymentGen::DTA.generate(transaction_number) do |dta|
      dta << DTAFactory.create_esr_payment
    end
    result.should be_kind_of(PaymentGen::DTA)
    result.records.should have(2).items
  end

  it "should create a file" do
    PaymentGen::DTA.create(transaction_number, dta_file_path) do |dta|
      dta << DTAFactory.create_esr_payment
    end
    File.exist?(dta_file_path).should be_true
  end

  it "should set the transaction_number for any record added" do
    file = PaymentGen::DTA.new("00123478901")
    file << DTAFactory.create_esr_payment
    file.records.first.transaction_number.should == "00123478901"
  end

  it "should calculate the entry_sequence_number" do
    file = PaymentGen::DTA.new
    file << DTAFactory.create_esr_payment
    file << DTAFactory.create_esr_payment
    file.finish
    file.records.map(&:entry_sequence_number).should == ['00001', '00002', '00003']
  end

  it "should calculate the total amount" do
    file = PaymentGen::DTA.new
    file << DTAFactory.create_esr_payment(:payment_amount => 420.50)
    file << DTAFactory.create_esr_payment(:payment_amount => 320.20)
    file.total.should == (420.50 + 320.20)
  end

  it "should calculate the total amount" do
    file = PaymentGen::DTA.new
    file << DTAFactory.create_esr_payment(:payment_amount => 67.95)
    file << DTAFactory.create_esr_payment(:payment_amount => 8204.70)
    file << DTAFactory.create_esr_payment(:payment_amount => 977.00)
    file.total.should == 9249.65
  end

  context "finishing" do
    it "must be finished when done adding records" do
      file = PaymentGen::DTA.new
      file << DTAFactory.create_esr_payment
      file << DTAFactory.create_esr_payment
      file.finish
      file.records.should have(3).items
    end

    it "can't add more records once it is finished" do
      file = PaymentGen::DTA.new
      file << DTAFactory.create_esr_payment
      file.finish
      lambda do
        file << DTAFactory.create_esr_payment
      end.should raise_error('the DTA has already been finished!')
    end

    it "can't be finished when no records have been added" do
      file = PaymentGen::DTA.new
      lambda do
        file.finish
      end.should raise_error('you need to add records before finishing the DTA!')
    end

    it "can't be finished twice" do
      file = PaymentGen::DTA.new
      file << DTAFactory.create_esr_payment
      file.finish
      lambda do
        file.finish
      end.should raise_error('the DTA has already been finished!')
    end
  end

  describe 'output' do
    it "can't be written to a stream unless it is finished" do
      file = PaymentGen::DTA.new
      file << DTAFactory.create_esr_payment
      lambda do
        file.write_to(StringIO.new)
      end.should raise_error('the DTA must be finished before you can write it.')
    end
  end

  describe PaymentGen::DTA, "file records" do
    before(:each) do
      @record1 = DTAFactory.create_esr_payment(:payment_amount => 2222.22)
      @record2 = DTAFactory.create_esr_payment(:payment_amount => 4444.44)
      stream = StringIO.new
      @dta_file = PaymentGen::DTA.new
      @dta_file << @record1
      @dta_file << @record2
      @dta_file.finish
      @dta_file.write_to(stream)
      stream.rewind
      @file_records = stream.readlines
    end

    it "should add the records to the file in dta format" do
      @file_records.should include(@record2.to_dta + "\n")
      @file_records.should include(@record2.to_dta + "\n")
    end

    it "should add a total record" do
      @file_records.last.should include("01000000            00000111115       PAYDT00003890006666,66                                                                    \n")
    end
  end
end
