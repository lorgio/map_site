require File.dirname(__FILE__) + '/../../spec_helper'

describe "/vcards/show.html.erb" do
  include VcardsHelper
  
  before(:each) do
    @vcard = mock_model(Vcard)
    @vcard.stub!(:location).and_return("MyString")
    @vcard.stub!(:street).and_return("MyString")
    @vcard.stub!(:locality).and_return("MyString")
    @vcard.stub!(:region).and_return("MyString")
    @vcard.stub!(:postalcode).and_return("MyString")
    @vcard.stub!(:country).and_return("MyString")
    @vcard.stub!(:first_name).and_return("MyString")
    @vcard.stub!(:last_name).and_return("MyString")
    @vcard.stub!(:org).and_return("MyString")
    @vcard.stub!(:email1).and_return("MyString")
    @vcard.stub!(:email1_type).and_return("MyString")
    @vcard.stub!(:email2).and_return("MyString")
    @vcard.stub!(:email2_type).and_return("MyString")
    @vcard.stub!(:lat).and_return("1.5")
    @vcard.stub!(:lng).and_return("1.5")

    assigns[:vcard] = @vcard
  end

  it "should render attributes in <p>" do
    render "/vcards/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/1\.5/)
    response.should have_text(/1\.5/)
  end
end

