require 'spec_helper'

describe PaymentGen::EZAGRecords::HeadRecord do

  describe "control section" do
    it "should set the transaction type to 00" do
      EZAGFactory.create_head_record.transaction_type.should == '00'
    end

    it "should set the transaction number" do
      EZAGFactory.create_head_record.transaction_number.should == '000000'
    end
  end

  describe "main section" do
    it "should leave the main section empty" do
      EZAGFactory.create_head_record.main_section.should == ' ' * 650
    end
  end

  describe "to_s" do
    it "returns the head record" do
      EZAGFactory.create_head_record(:due_date => '8.4.2018', :account_number => '34-847382-4').to_s.should == "03618040800000134847382434847382401000000000000000#{' '*650}"
    end
  end

end
