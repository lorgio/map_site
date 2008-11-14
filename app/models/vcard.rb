class Vcard < ActiveRecord::Base
  acts_as_mappable  :default_units => :miles, 
                    :default_formula => :flat, 
                    :distance_field_name => :distance
                    
  attr_accessor :datafile
  
  before_create :geocode_address
  before_validation_on_update :geocode_address

  def self.process_cards(cards)
    cards.each do |card|
      if card['X-ABSHOWAS'].eql?("COMPANY")      
        last_name, first_name = card['N'].split(';')
        full_name = card['FN']
        home_phone = card['TEL', 'HOME']
        work_phone = card['TEL', 'WORK']      
        address_work = card['ADR', 'WORK']
        address_work = address_work.gsub(/\\,/,'.') if address_work.kind_of?(String)
        address_work = address_work.gsub(/\\,/,'.') if address_work.kind_of?(String)
        logger.debug { "ADDRES_WORK:#{address_work}" }
        street, city, state, zip_code, country  = address_work.split(";").delete_if {|x| x.blank?} unless address_work.blank?
        # street, city, state, zip_code, country  = address_work.split(";").delete("") unless address_work.blank?
        title = card['TITLE']
        org = card['ORG']
        org = org.gsub(/\\,/,'.') if org.kind_of?(String)
        url = card['URL']
        notes = card['NOTE']

        vcard1 = Vcard.create :first_name => first_name,
                              :last_name  => last_name,
                              :org        => org.gsub(';',''),
                              :work_phone => work_phone,
                              :home_phone => home_phone,
                              :url        => url.blank? ? nil : url.gsub("http://",'') ,
                              :street     => street, 
                              :city       => city, 
                              :state      => state, 
                              :zip_code   => zip_code, 
                              :country    => country
      end
    end
  end
  
  private
  def geocode_address
    loc = GeoKit::Geocoders::GoogleGeocoder.geocode("#{street}, #{city}, #{state} #{zip_code}")  
    if loc.success  
      # update_attributes(:street => loc.street_address,:city=> loc.city,:country => loc.country_code,
      #                   :zip_code => loc.zip, :state => loc.state,:lng =>loc.lng, :lat => loc.lat)     
      self.lat, self.lng = loc.lat,loc.lng 
    end
  end
  
end
