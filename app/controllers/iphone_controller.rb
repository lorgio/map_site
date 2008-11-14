class IphoneController < ApplicationController
  acts_as_iphone_controller  :test_mode => true#, :subdomain => iphone
  
  
  def index    
    respond_to do |format|
      # format.html # show.html.erb
      format.xml  { render :xml => @feature }
      format.iphone
    end    
  end
  
  def search_results        
    loc = GeoKit::Geocoders::GoogleGeocoder.geocode(params[:vcard][:street])                
    @vcards = Vcard.find(:all, :origin =>[loc.lat,loc.lng], :within=>params[:vcard][:distance],:conditions=>"org is not null", :order=>"distance") 
    # raise @vcards.to_yaml
    respond_to do |format|      
      format.html # show.html.erb      
      format.iphone 
    end
  end
  
  def show
    @vcard = Vcard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vcard }
      format.iphone       
    end
  end
  
end
