require 'spec_helper'

describe DtaGen do

  let(:dta_file_path) { File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'tmp', 'payments.dta')) }


  it "should create a file" do
    DtaGen.create(dta_file_path) do |dta|
      dta << PaymentFactory.create_esr_payment
    end
    File.exist?(dta_file_path).should be_true
  end


end
