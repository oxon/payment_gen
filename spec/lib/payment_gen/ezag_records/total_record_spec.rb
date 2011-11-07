require 'spec_helper'

describe PaymentGen::EZAGRecords::TotalRecord do

  describe "control section" do
    it "should set the transaction type to 00" do
      EZAGFactory.create_total_record.transaction_type.should == '97'
    end

    it "should calculate a transaction number from the input" do
      EZAGFactory.create_total_record(:totals => {
                                        'HAS' => {:transactions => 5},
                                        'UAF' => {:transactions => 9}
                                      }).transaction_number.should == '000015'
    end
  end

  describe "to_s" do
    it "returns the total record" do
      record = EZAGFactory.create_total_record({
                                                 :due_date => '14.8.1893',
                                                 :account_number => '84-384473-2',
                                                 :totals => {
                                                   'CHF' => {:total => 832, :transactions => 4},
                                                   'UAH' => {:total => 98, :transactions => 2}
                                                 }
                                               })
      record.to_s.should == "03693081400000184384473284384473201970000070000000CHF0000040000000083200UAH0000020000000009800#{'0' * 13 * 22}#{' ' * 320}"
    end
  end

end
