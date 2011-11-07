require 'spec_helper'

describe PaymentGen::DTARecords::TotalRecord do
  it 'should have the segment 1 field set' do
    DTAFactory.create_total_record.segment1[0,2].should == '01'
  end

  it 'should have a total amount' do
    DTAFactory.create_total_record(:total_amount => 789325.451).segment1[53,16].should == '789325,451      '
  end

  it "should have a reserve field with 59 blanks" do
    DTAFactory.create_total_record.segment1[69,59].should == ''.ljust(59)
  end

  it "should have a total length of 128 characters" do
    DTAFactory.create_total_record.record.size.should == 128
  end
end
