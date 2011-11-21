require 'spec_helper'

describe PaymentGen::DTARecords::DomesticCHFPayment do

  it "should have a total length of 640 characters with end beneficiary" do
    DTAFactory.create_domestic_chf_payment(:end_beneficiarys_bank_account_number =>'1').record.size.should == 640
  end

  it "should have a total length of 512 characters" do
    DTAFactory.create_domestic_chf_payment.record.size.should == 512
  end


  describe 'segment 1' do
    it 'should set the segment field to 01' do
      DTAFactory.create_domestic_chf_payment.segment1[0,2].should == '01'
    end

    it 'should have a reference number' do
      DTAFactory.create_domestic_chf_payment(:issuer_identification => 'ABC01', :transaction_number => '00123478901').segment1[53,16].should == "ABC0100123478901"
    end

    it 'should have an account to be debited without IBAN justified left filled with blanks' do
      DTAFactory.create_domestic_chf_payment(:account_to_be_debited => '10235678').segment1[69,24].should == '10235678                '
    end

    it 'should have an account to be debited with IBAN' do
      DTAFactory.create_domestic_chf_payment(:account_to_be_debited => 'CH9300762011623852957').segment1[69,24].should == 'CH9300762011623852957   '
    end

    it 'should have a blank payment amount valuta (6 blanks)' do
      DTAFactory.create_domestic_chf_payment.segment1[93,6].should == '      '
    end

    it 'should have a payment amount currency code' do
     DTAFactory.create_domestic_chf_payment(:payment_amount_currency => 'CHF').segment1[99,3].should == 'CHF'
    end

    it 'should have a payment amount justified left filled with blanks' do
      DTAFactory.create_domestic_chf_payment(:payment_amount => '3949,75').segment1[102,12].should == '3949,75     '
    end

    it 'should use the swift convention to format the amount' do
      DTAFactory.create_domestic_chf_payment(:payment_amount => '110.45').segment1[102,12].should == '110,45      '
      DTAFactory.create_domestic_chf_payment(:payment_amount => 237.05).segment1[102,12].should == '237,05      '
    end

    it 'should have a reserve field' do
      DTAFactory.create_domestic_chf_payment.segment1[114,14].should == ' '.ljust(14)
    end

    it 'should have a total length of 128 characters' do
      DTAFactory.create_domestic_chf_payment.segment1.size.should == 128
    end
  end
  describe 'segment 2' do
    it 'should set the segment field to 02' do
      DTAFactory.create_domestic_chf_payment.segment2[0,2].should == '02'
    end

    it 'should have an ordering partys address line 1' do
      DTAFactory.create_domestic_chf_payment(:ordering_partys_address_line1 => 'John Doe').segment2[2,24].should == 'John Doe'.ljust(24)
    end

    it 'should have an ordering partys address line 2' do
      DTAFactory.create_domestic_chf_payment(:ordering_partys_address_line2 => 'Bahnhofstrasse 1').segment2[26,24].should == 'Bahnhofstrasse 1'.ljust(24)
    end

    it 'should have an ordering partys address line 3' do
      DTAFactory.create_domestic_chf_payment(:ordering_partys_address_line3 => '8000 Zurich').segment2[50,24].should == '8000 Zurich'.ljust(24)
    end

    it 'should have an ordering partys address line 4' do
      DTAFactory.create_domestic_chf_payment(:ordering_partys_address_line4 => 'Schweiz').segment2[74,24].should == 'Schweiz'.ljust(24)
    end

    it 'should have a posting text ' do
      DTAFactory.create_domestic_chf_payment(:posting_text => 'Invoice 1234').segment2[98..-1].should == 'Invoice 1234                  '
    end

    it 'should have a length of 128 characters' do
      DTAFactory.create_domestic_chf_payment.segment2.size.should == 128
    end
  end

  describe 'segment 3' do
    it 'should set the segment field to 03' do
      DTAFactory.create_domestic_chf_payment.segment3[0,2].should == '03'
    end

    it 'should have the beneficiarys bank account number' do
    DTAFactory.create_domestic_chf_payment(:beneficiarys_bank_account_number =>'111222333').segment3[2,30].should == '/C/111222333'.ljust(30)
    end

    it 'should have a  address line 1' do
      DTAFactory.create_domestic_chf_payment(:beneficiary_address_line1 => 'Michael Recipient').segment3[32,24].should == 'Michael Recipient'.ljust(24)
    end

    it 'should have a beneficiary address line 2' do
      DTAFactory.create_domestic_chf_payment(:beneficiary_address_line2 => 'Empfaengerstrasse 1').segment3[56,24].should == 'Empfaengerstrasse 1'.ljust(24)
    end

    it 'should have a beneficiary address line 3' do
      DTAFactory.create_domestic_chf_payment(:beneficiary_address_line3 => '8640 Rapperswil').segment3[80,24].should == '8640 Rapperswil'.ljust(24)
    end

    it 'should have a beneficiary address line 4' do
      DTAFactory.create_domestic_chf_payment(:beneficiary_address_line4 => 'Schweiz').segment3[104,24].should == 'Schweiz'.ljust(24)
    end

    it 'should have a length of 128 characters' do
      DTAFactory.create_domestic_chf_payment.segment3.size.should == 128
    end
  end

  describe 'segment 4' do
    it 'should set the segment field to 04' do
      DTAFactory.create_domestic_chf_payment.segment4[0,2].should == '04'
    end

    it "should have a reson for payment message line 1" do
      DTAFactory.create_domestic_chf_payment(:reason_for_payment_message_line1 => 'LINE1').segment4[2,28].should == 'LINE1'.ljust(28)
    end

    it "should have a reson for payment message line 2" do
      DTAFactory.create_domestic_chf_payment(:reason_for_payment_message_line2 => 'LINE2').segment4[30,28].should == 'LINE2'.ljust(28)
    end

    it "should have a reson for payment message line 3" do
      DTAFactory.create_domestic_chf_payment(:reason_for_payment_message_line3 => 'LINE3').segment4[58,28].should == 'LINE3'.ljust(28)
    end

    it "should have a reson for payment message line 4" do
      DTAFactory.create_domestic_chf_payment(:reason_for_payment_message_line4 => 'LINE4').segment4[86,28].should == 'LINE4'.ljust(28)
    end

    it 'should have a reserve field' do
      DTAFactory.create_domestic_chf_payment.segment4[114,14].should == ' '.ljust(14)
    end

    it 'should have a length of 128 characters' do
      DTAFactory.create_domestic_chf_payment.segment4.size.should == 128
    end
  end

  describe 'segment 5' do
    subject { DTAFactory.create_domestic_chf_payment(:end_beneficiarys_bank_account_number =>'111222333',
                                                     :end_beneficiary_address_line1 => 'Michael Recipient',
                                                     :end_beneficiary_address_line2 => 'Empfaengerstrasse 1',
                                                     :end_beneficiary_address_line3 => '8640 Rapperswil',
                                                     :end_beneficiary_address_line4 => 'Schweiz'
                                                     ) }
    it 'should set the segment field to 05' do
      subject.segment5[0,2].should == '05'
    end

    it 'should have the end beneficiarys bank account number' do
      subject.segment5[2,30].should == '/C/111222333'.ljust(30)
    end

    it 'should be nil when no end beneficiarys bank account number is given' do
    DTAFactory.create_domestic_chf_payment(:end_beneficiarys_bank_account_number =>'').segment5.should == ''

    end

    it 'should have an end beneficiary address line 1' do
      subject.segment5[32,24].should == 'Michael Recipient'.ljust(24)
    end

    it 'should have an beneficiary address line 2' do
      subject.segment5[56,24].should == 'Empfaengerstrasse 1'.ljust(24)
    end

    it 'should have an end beneficiary address line 3' do
      subject.segment5[80,24].should == '8640 Rapperswil'.ljust(24)
    end

    it 'should have an end beneficiary address line 4' do
      subject.segment5[104,24].should == 'Schweiz'.ljust(24)
    end

    it 'should have a length of 128 characters' do
      subject.segment5.size.should == 128
    end
  end
end
