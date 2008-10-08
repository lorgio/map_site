require File.dirname(__FILE__) + '/../../spec_helper'

describe "/vcards/index.html.erb" do
  include VcardsHelper
  
  before(:each) do
    vcard_98 = mock_model(Vcard)
    vcard_98.should_receive(:location).and_return("MyString")
    vcard_98.should_receive(:street).and_return("MyString")
    vcard_98.should_receive(:locality).and_return("MyString")
    vcard_98.should_receive(:region).and_return("MyString")
    vcard_98.should_receive(:postalcode).and_return("MyString")
    vcard_98.should_receive(:country).and_return("MyString")
    vcard_98.should_receive(:first_name).and_return("MyString")
    vcard_98.should_receive(:last_name).and_return("MyString")
    vcard_98.should_receive(:org).and_return("MyString")
    vcard_98.should_receive(:email1).and_return("MyString")
    vcard_98.should_receive(:email1_type).and_return("MyString")
    vcard_98.should_receive(:email2).and_return("MyString")
    vcard_98.should_receive(:email2_type).and_return("MyString")
    vcard_98.should_receive(:lat).and_return("1.5")
    vcard_98.should_receive(:lng).and_return("1.5")
    vcard_99 = mock_model(Vcard)
    vcard_99.should_receive(:location).and_return("MyString")
    vcard_99.should_receive(:street).and_return("MyString")
    vcard_99.should_receive(:locality).and_return("MyString")
    vcard_99.should_receive(:region).and_return("MyString")
    vcard_99.should_receive(:postalcode).and_return("MyString")
    vcard_99.should_receive(:country).and_return("MyString")
    vcard_99.should_receive(:first_name).and_return("MyString")
    vcard_99.should_receive(:last_name).and_return("MyString")
    vcard_99.should_receive(:org).and_return("MyString")
    vcard_99.should_receive(:email1).and_return("MyString")
    vcard_99.should_receive(:email1_type).and_return("MyString")
    vcard_99.should_receive(:email2).and_return("MyString")
    vcard_99.should_receive(:email2_type).and_return("MyString")
    vcard_99.should_receive(:lat).and_return("1.5")
    vcard_99.should_receive(:lng).and_return("1.5")

    assigns[:vcards] = [vcard_98, vcard_99]
  end

  it "should render list of vcards" do
    render "/vcards/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "1.5", 2)
    response.should have_tag("tr>td", "1.5", 2)
  end
end

