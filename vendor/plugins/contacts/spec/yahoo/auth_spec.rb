require File.dirname(__FILE__) + '/../spec_helper'
require 'contacts/yahoo'
require 'uri'

describe Contacts::Yahoo, '.authentication_url' do
  it 'generates a URL for target with default parameters' do    
    url = Contacts::Yahoo.authentication_url
    uri = URI::parse(url)
    uri.host.should == 'api.login.yahoo.com'
    uri.scheme.should == 'https'
    uri.query.split('&').size.should == 4
    params = uri.query.split('&').map { |param| key = param.sub(/=.*/,'') }
    params.include?('sig').should be_true
    params.include?('appid').should be_true
    params.include?('send_userhash').should be_true
    params.include?('ts').should be_true
  end
  
  it 'should be able to exchange token for cookie and wssid' do
    connection = mock('HTTP connection')
    response = mock('HTTP response')
    Net::HTTP.expects(:start).with('api.login.yahoo.com',443).yields(connection).returns(response)
    connection.expects(:use_ssl)
    connection.expects(:verify_mode=).with(OpenSSL::SSL::VERIFY_NONE)
    connection.expects(:get)

    response.expects(:body).returns(sample_xml('yahoo-auth'))

    lambda { Contacts::Yahoo.new('dummytoken') }.should_not raise_error
  end

  def sample_xml(name)
    File.read File.dirname(__FILE__) + "/../feeds/#{name}.xml"
  end  
end