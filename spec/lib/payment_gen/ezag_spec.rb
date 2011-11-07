require 'spec_helper'

describe PaymentGen::EZAG do

  it "should generate an EZAG object" do
    result = PaymentGen::EZAG.generate do |ezag|
      ezag << EZAGFactory.create_head_record
    end
    result.should be_kind_of(PaymentGen::EZAG)
    result.records.should have(1).item
  end

  describe PaymentGen::EZAG, "file records" do
    let(:record1) { EZAGFactory.create_domestic_post_account_record }
    let(:record2) { EZAGFactory.create_domestic_post_account_record }

    before :each do
      stream = StringIO.new
      file = PaymentGen::EZAG.new
      file << record1
      file << record2
      file.write_to stream
      stream.rewind
      @file_records = stream.readlines
    end

    it "should add the records to the file" do
      @file_records.should include(record1.to_s + "\n")
      @file_records.should include(record2.to_s + "\n")
    end
  end

end
