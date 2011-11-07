require 'spec_helper'

describe PaymentGen::EZAGRecords::Base do

  describe "control section" do
    it "should set the due date" do
      EZAGFactory.create_record(:due_date => '6.8.1928').due_date.should == '280806'
    end

    it "should set the due date to 000000 for an invalid date" do
      EZAGFactory.create_record(:due_date => nil).due_date.should == '000000'
    end

    it "should set the account number" do
      EZAGFactory.create_record(:account_number => '30-893725-4').account_number.should == '308937254'
    end

    it "should set the transaction type to 00" do
      EZAGFactory.create_record.transaction_type.should == '00'
    end

    describe "transaction number" do
      subject { EZAGFactory.create_record }

      it "should be able to set the transaction number" do
        subject.transaction_number = 9
        subject.transaction_number.should == '000009'
      end
    end
  end

end
