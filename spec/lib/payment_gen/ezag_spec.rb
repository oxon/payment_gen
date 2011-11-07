require 'spec_helper'

describe PaymentGen::EZAG do

  let(:default_attributes) { {:due_date => '2.4.2019', :account_number => '38-384722-8'} }
  subject { PaymentGen::EZAG.new(default_attributes) }

  let(:ezag_file_path) { File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'tmp', 'payments.ezag')) }

  it "should generate an EZAG object" do
    result = PaymentGen::EZAG.generate do |ezag|
      ezag << EZAGFactory.create_head_record
    end
    result.should be_kind_of(PaymentGen::EZAG)
    result.records.should have(1).item
  end

  it "should create a file" do
    PaymentGen::EZAG.create(ezag_file_path, default_attributes) do |ezag|
      ezag << EZAGFactory.create_domestic_post_account_record
    end
    File.exist?(ezag_file_path).should be_true
  end

  describe PaymentGen::EZAG, "file records" do
    let(:record1) { EZAGFactory.create_domestic_post_account_record }
    let(:record2) { EZAGFactory.create_domestic_post_account_record }

    before :each do
      stream = StringIO.new
      subject << record1
      subject << record2
      subject.write_to stream
      stream.rewind
      @file_records = stream.readlines
    end

    it "should add the records to the file" do
      @file_records.should include(record1.to_s + "\n")
      @file_records.should include(record2.to_s + "\n")
    end

    it "should contain a head record" do
      @file_records.should include(subject.send(:head_record).to_s + "\n")
    end

    it "should set the transaction numbers of the two records" do
      record1.transaction_number.should == '000001'
      record2.transaction_number.should == '000002'
    end

    it "should contain a total record" do
      @file_records.should include(subject.send(:total_record).to_s + "\n")
    end
  end

  describe "head record" do
    it "should generate a head record" do
      subject.send(:head_record).should be_kind_of(PaymentGen::EZAGRecords::HeadRecord)
    end
  end

  describe "total record" do
    it "should generate a total record" do
      subject.send(:total_record).should be_kind_of(PaymentGen::EZAGRecords::TotalRecord)
    end
  end

  describe "#totals" do
    it "calculates the total for one currency" do
      subject << EZAGFactory.create_domestic_post_account_record(:payment_amount => 83)
      subject << EZAGFactory.create_domestic_post_account_record(:payment_amount => 95.3)
      subject.send(:totals).should == {'CHF' => {:total => 178.3, :transactions => 2}}
    end

    it "separates different currencies" do
      subject << EZAGFactory.create_domestic_post_account_record(:payment_amount => 83)
      subject << EZAGFactory.create_domestic_post_account_record(:payment_amount => 95.3, :source_currency => 'DOL')
      subject.send(:totals).should == {
        'CHF' => {:total => 83, :transactions => 1},
        'DOL' => {:total => 95.3, :transactions => 1}
      }
    end
  end

end
