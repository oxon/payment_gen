require 'spec_helper'

describe PaymentGen do

  let(:transaction_number) { '12345' }
  let(:dta_file_path) { File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'tmp', 'payments.dta')) }

  it "should generate a DTA object" do
    result = PaymentGen.generate(transaction_number) do |dta|
      dta << PaymentFactory.create_esr_payment
    end
    result.should be_kind_of(PaymentGen::DTA)
    result.records.should have(1).item
  end

  it "should create a file" do
    PaymentGen.create(transaction_number, dta_file_path) do |dta|
      dta << PaymentFactory.create_esr_payment
    end
    File.exist?(dta_file_path).should be_true
  end


end
