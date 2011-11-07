require 'spec_helper'

describe PaymentGen::EZAG do

  let(:default_attributes) { {:due_date => '2.4.2019', :account_number => '38-384722-8'} }
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
    subject { PaymentGen::EZAG.new(default_attributes) }

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
      @file_records.should include(subject.head_record.to_s + "\n")
    end
  end

  describe "head record" do
    subject { PaymentGen::EZAG.new(default_attributes) }

    it "should have a head record" do
      subject.head_record.should be_kind_of(PaymentGen::EZAGRecords::HeadRecord)
    end
  end

end
