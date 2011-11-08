require 'spec_helper'

describe PaymentGen do

  describe "#dta" do
    it "returns the DTA class" do
      PaymentGen.dta.should == PaymentGen::DTA
    end
  end

  describe "#ezag" do
    it "returns the EZAG class" do
      PaymentGen.ezag.should == PaymentGen::EZAG
    end
  end

end
