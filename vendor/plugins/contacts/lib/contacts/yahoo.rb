require 'digest/md5'
require 'hpricot'
require 'cgi'
require 'net/http'
require 'net/https'
require 'contacts'
require 'zlib'
require 'stringio'

module Contacts
  # -- fetching Yahoo contacts --
  # Two steps:
  #  - the user authenticates with Yahoo (BBAuth protocol)
  #  - his contacts are retrieved using the Yahoo Address API (http://developer.yahoo.com/addressbook/guide/MakingTheRequest.html)
  #
  # For BBAuth, the web application needs to be registered with Yahoo first.
  # http://developer.yahoo.com/auth/appreg.html  
  # The registration yields two data:
  #  - the app ID
  #  - a secret
  # both have to be stored in the constants below
  #  APPLICATION_ID =
  #  SECRET =
  #
  # How to use in your code
  #  Authentication redirection:
  #    redirect_to Contacts::Yahoo.authentication_url
  #  After authentication, the user is redirected to the page specified during registration
  #  The contacts are retrieved by creating an instance of the Yahoo class
  #    yahoo = Contacts::Yahoo.new(params[:token])
  #    contacts = yahoo.contacts 
  # The returned result is an array of arrays: [[name1,email1],[name2,email21,email22],[name3,email3],...]
  #
  # The class Yahoo is modeled on the class Google written by Mislav Marohnić.
  # details of BBAuth have been checked against the Yahoo BBAuth plugin described in
  # http://chuddup.com/blog/archive/27/drop-in-yahoo-browser-
  #
  # This plugin was written for the channl.tv application (for VRT Medialab, a subdivision of the Flemish public broadcaster VRT) 
  # check out http://www.channl.tv
  # http://www.channl.tv will change the way you experience video available online.
  #
  # Author: Elise Huard - 11/06/2008
  # MIT License
  class Yahoo
    BBAUTHDOMAIN="api.login.yahoo.com"
    BBAUTHINIT="/WSLogin/V1/wslogin"
    BBAUTHCOOKIE="/WSLogin/V1/wspwtoken_login"

    ADDRESSDOMAIN="address.yahooapis.com"    
    ADDRESSQUERY="/v1/searchContacts"

    # fill in with appropriate data from registration with Yahoo
    APPLICATION_ID=""
    SECRET=""

    def self.authentication_url(options = {})
      params = { :appid => APPLICATION_ID,
                 :ts => Time.now.to_i,
                 :send_userhash => true
               }.merge(options)
      signature = generate_signature(BBAUTHINIT + '?' + query_from_params(params))
      "https://" + BBAUTHDOMAIN + BBAUTHINIT + '?' + query_from_params(params) + '&sig=' + signature
    end

    # Token is required here.
    # TODO: a signature is returned, this can be double-checked to verify whether the info comes from Yahoo - not critical for contacts retrieval

    def initialize(token)
      request_yahoo_cookie(token)
    end

    def get_addresses(options = {})
      @headers = { 'Accept-Encoding' => 'gzip','Cookie' => @cookie }.update(self.class.auth_headers)
      params = { :fields => 'name,email' }.merge(options)
      contacts_query = ADDRESSQUERY + "?format=xml&" + Yahoo.query_from_params(params)  + "&appid=" + APPLICATION_ID + "&WSSID=" + @wssid
      response = get(ADDRESSDOMAIN,contacts_query,@headers)
    end

    def contacts(options = {})
      response = get_addresses(options)
      parse_contacts response_body(response)
    end

protected
    def request_yahoo_cookie(token)
      params = { :appid => APPLICATION_ID,
                 :token => token,
                 :ts => Time.now.to_i
               }
      signature = Yahoo.generate_signature(BBAUTHCOOKIE + '?' + Yahoo.query_from_params(params))
      query = BBAUTHCOOKIE + '?' + Yahoo.query_from_params(params) + '&sig=' + signature
      response = get_secure(BBAUTHDOMAIN,query)
      parse_authentication_data(response)
    end

    def response_body(response)
      unless response['Content-Encoding'] == 'gzip'
        response.body
      else
        gzipped = StringIO.new(response.body)
        Zlib::GzipReader.new(gzipped).read
      end
    end

    # takes hash of parameters as argument and returns the resulting param string to be added at the end of an url string
    # should ALWAYS have same order for signature (and sig parameter is added at the end in query itself)
    def self.query_from_params(params)
      sorted_keys =  params.keys.sort {|a,b| a.to_s <=> b.to_s }
      query = sorted_keys.inject [] do |url, key|
       unless params[key].nil?
         value = case params[key]
           when TrueClass; 1
           when FalseClass; 0
           else params[key]
           end
         url << "#{key}=#{CGI.escape(params[key].to_s)}"
       end
       url
      end.join('&')
      query
    end


    # parses the authentication data and stores them in attributes.  These should normally be valid for one hour.
    def parse_authentication_data(body)
      doc = Hpricot::XML body
      wssid_node = doc.at('/BBAuthTokenLoginResponse/Success/WSSID')
      if wssid_node
        @wssid = wssid_node.inner_text
      else
        raise AuthenticationException('WSSID not present.')
      end
      cookie_node = doc.at('/BBAuthTokenLoginResponse/Success/Cookie')
      if cookie_node
        @cookie = cookie_node.inner_text.gsub(/[ \n]/m,'')
      else
        raise AuthenticationException('Authentication cookie not present.')
      end
    end

    def parse_contacts(body)
      doc = Hpricot::XML body
      entries = []

      (doc / '/search-response/contact').each do |entry|

          email_nodes = entry /'email'
          first_name_node = entry /'/name/first'
          last_name_node = entry /'/name/last'
          person = nil
          unless email_nodes.empty?
            name = nil
            name = first_name_node.inner_text if first_name_node
            name += ' ' if first_name_node && last_name_node
            name += last_name_node.inner_text if last_name_node
            person = [name]
            email_nodes.each do |email_node|
              person << email_node.inner_text.gsub(/\n/,'').gsub(/ /,'') # chomp does not seem to work ?
            end
          end
          entries << person
      end
      entries
    end

    def self.auth_headers
      { 'HTTP_COOKIE' => @cookie }
    end

    def get_secure(domain,query,headers = nil) #:nodoc:
      https = Net::HTTP.new(domain,443)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      response, data = https.get(query,headers)
      data
    end

    def get(domain,query,headers = nil)
      response = Net::HTTP.start(domain) do |yahoo|
        yahoo.get(query,headers)
      end
      raise FetchingError.new(response) unless response.is_a? Net::HTTPSuccess
      response
    end

    def self.generate_signature(url)
      Digest::MD5.hexdigest(url + SECRET)
    end

  end
end

class AuthenticationException < Exception
end
