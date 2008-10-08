require File.dirname(__FILE__) + '/../spec_helper'

describe Vcard do
  before(:each) do
    @vcard = Vcard.new
  end

  it "should be valid" do
    @vcard.should be_valid
  end
end
