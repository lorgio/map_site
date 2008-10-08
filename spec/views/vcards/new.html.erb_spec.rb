require File.dirname(__FILE__) + '/../../spec_helper'

describe "/vcards/new.html.erb" do
  include VcardsHelper
  
  before(:each) do
    @vcard = mock_model(Vcard)
    @vcard.stub!(:new_record?).and_return(true)
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

  it "should render new form" do
    render "/vcards/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", vcards_path) do
      with_tag("input#vcard_location[name=?]", "vcard[location]")
      with_tag("input#vcard_street[name=?]", "vcard[street]")
      with_tag("input#vcard_locality[name=?]", "vcard[locality]")
      with_tag("input#vcard_region[name=?]", "vcard[region]")
      with_tag("input#vcard_postalcode[name=?]", "vcard[postalcode]")
      with_tag("input#vcard_country[name=?]", "vcard[country]")
      with_tag("input#vcard_first_name[name=?]", "vcard[first_name]")
      with_tag("input#vcard_last_name[name=?]", "vcard[last_name]")
      with_tag("input#vcard_org[name=?]", "vcard[org]")
      with_tag("input#vcard_email1[name=?]", "vcard[email1]")
      with_tag("input#vcard_email1_type[name=?]", "vcard[email1_type]")
      with_tag("input#vcard_email2[name=?]", "vcard[email2]")
      with_tag("input#vcard_email2_type[name=?]", "vcard[email2_type]")
      with_tag("input#vcard_lat[name=?]", "vcard[lat]")
      with_tag("input#vcard_lng[name=?]", "vcard[lng]")
    end
  end
end


