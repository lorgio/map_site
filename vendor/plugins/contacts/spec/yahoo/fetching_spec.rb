require File.dirname(__FILE__) + '/../spec_helper'
require 'contacts/yahoo'

describe Contacts::Yahoo do

  before :each do
    @yahoo = create
  end
  
  it 'fetches contacts feed via HTTP GET' do
    connection = mock('HTTP connection')
    response = mock('HTTP response')
    response.stubs(:is_a?).with(Net::HTTPSuccess).returns(true)
    Net::HTTP.expects(:start).with('address.yahooapis.com').yields(connection).returns(response)
    connection.expects(:get).with('/v1/searchContacts?WSSID=RJC.2hSsIkd&fields=name%2Cemail&format=xml', {'HTTP_COOKIE' => nil, 'Accept-Encoding' => 'gzip'})

    @yahoo.get_addresses
  end
  
  it 'handles a normal response body' do
    response = mock('HTTP response')
    @yahoo.expects(:get_addresses).returns(response)

    response.expects(:'[]').with('Content-Encoding').returns(nil)
    response.expects(:body).returns('<search-response/>')

    @yahoo.expects(:parse_contacts).with('<search-response/>')
    @yahoo.contacts
  end
  
  it 'handles gzipped response' do
    response = mock('HTTP response')
    @yahoo.expects(:get_addresses).returns(response)

    gzipped = StringIO.new
    gzwriter = Zlib::GzipWriter.new gzipped
    gzwriter.write(('a'..'z').to_a.join)
    gzwriter.close

    response.expects(:'[]').with('Content-Encoding').returns('gzip')
    response.expects(:body).returns gzipped.string

    @yahoo.expects(:parse_contacts).with('abcdefghijklmnopqrstuvwxyz')
    @yahoo.contacts
  end

  it 'raises a FetchingError when something goes awry' do
    response = mock('HTTP response', :code => 666, :class => Net::HTTPBadRequest, :message => 'oh my')
    Net::HTTP.expects(:start).returns(response)

    lambda {
      @yahoo.get_addresses({})
    }.should raise_error(Contacts::FetchingError)
  end
  
  it 'parses the resulting feed into name/email pairs' do
    @yahoo.stubs(:get_addresses)
    @yahoo.expects(:response_body).returns(sample_xml('yahoo-single'))

    @yahoo.contacts.should == [['Mike Smith', 'mike@smith.co.uk']]
  end


  it 'parses a complex feed into name/email pairs' do
    @yahoo.stubs(:get_addresses)
    @yahoo.expects(:response_body).returns(sample_xml('yahoo-many'))

    @yahoo.contacts.should == [
      ['Mike Smith', 'mike@smith.co.uk'],
      ['Hillary Clinton', 'hillary@politics.com', 'hillary@home.biz'],
      ['Barack Obama', 'barack@obama.com']
    ]
  end
    
  def create
    connection = stub('HTTP connection')
    response = stub('HTTP response')
    Net::HTTP.stubs(:start).yields(connection).returns(response)
    connection.stubs(:use_ssl)
    connection.stubs(:verify_mode=).with(OpenSSL::SSL::VERIFY_NONE)
    connection.stubs(:get)
    response.stubs(:body).returns(sample_xml('yahoo-auth'))
    Contacts::Yahoo.new('dummytoken')
  end

  def sample_xml(name)
    File.read File.dirname(__FILE__) + "/../feeds/#{name}.xml"
  end
end
