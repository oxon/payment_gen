require 'spec_helper'

describe DtaGen::Payments::Base do

  let(:too_long_text) { 'I am way to long to fit in this line of the beneficiary adress' }

  describe "beneficiary_address" do
    it "trims beneficiary_address_line1, when it exceedes the maximum length" do
      record = DtaGen::Payments::Base.new(:beneficiary_address_line1 => too_long_text)
      record.beneficiary_address_line1(20).should == 'I am way to long to '
    end

    it "trims beneficiary_address_line2, when it exceedes the maximum length" do
      record = DtaGen::Payments::Base.new(:beneficiary_address_line2 => too_long_text)
      record.beneficiary_address_line2(20).should == 'I am way to long to '
    end

    it "trims beneficiary_address_line3, when it exceedes the maximum length" do
      record = DtaGen::Payments::Base.new(:beneficiary_address_line3 => too_long_text)
      record.beneficiary_address_line3(20).should == 'I am way to long to '
    end

    it "trims beneficiary_address_line4, when it exceedes the maximum length" do
      record = DtaGen::Payments::Base.new(:beneficiary_address_line4 => too_long_text)
      record.beneficiary_address_line4(20).should == 'I am way to long to '
    end
  end

  describe "ordering_partys_address" do
    it "trims ordering_partys_address_line1, when it exceedes the maximum length" do
      record = DtaGen::Payments::Base.new(:ordering_partys_address_line1 => too_long_text)
      record.ordering_partys_address_line1(20).should == 'I am way to long to '
    end

    it "trims ordering_partys_address_line2, when it exceedes the maximum length" do
      record = DtaGen::Payments::Base.new(:ordering_partys_address_line2 => too_long_text)
      record.ordering_partys_address_line2(20).should == 'I am way to long to '
    end

    it "trims ordering_partys_address_line3, when it exceedes the maximum length" do
      record = DtaGen::Payments::Base.new(:ordering_partys_address_line3 => too_long_text)
      record.ordering_partys_address_line3(20).should == 'I am way to long to '
    end

    it "trims ordering_partys_address_line4, when it exceedes the maximum length" do
      record = DtaGen::Payments::Base.new(:ordering_partys_address_line4 => too_long_text)
      record.ordering_partys_address_line4(20).should == 'I am way to long to '
    end
  end

end
