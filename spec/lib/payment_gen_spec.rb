require 'spec_helper'

describe PaymentGen do

  describe "#dta" do
    it "returns the DTA class" do
      PaymentGen.dta.should == PaymentGen::DTA
    end
  end

end
