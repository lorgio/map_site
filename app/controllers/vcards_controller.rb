require 'vpim/vcard'
include GeoKit::Mappable

class VcardsController < ApplicationController

  # GET /vcards
  # GET /vcards.xml
  def index
    @vcards = Vcard.find(:all, :conditions => "state='NY'")
    @vcard = Vcard.new

    @map = GMap.new("map_div_id")  
    @map.control_init(:large_map => true, :map_type => true)  
    @map.center_zoom_init([40.764762,	-73.978232], 15)  
    markers = []

    @vcards.each do |card|
      if card.eql?(@vcards.first)
        @map.overlay_init(GMarker.new([card.lat, card.lng], :info_window => card.org))
      else        
        @map.overlay_init(GMarker.new([card.lat, card.lng], :info_window => card.org))        
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vcards }
    end
  end

  def import
    cards = Vpim::Vcard.decode(params[:vcard][:datafile].read)                

    Vcard.process_cards(cards)

    respond_to do |format|
      flash[:notice] = 'Vcard was successfully created.'
      format.html { redirect_to(vcards_url) }
    end    
  end


  def search
    logger.debug { "PLACE: #{params[:vcard][:street]}" }
    loc = GeoKit::Geocoders::GoogleGeocoder.geocode(params[:vcard][:street])    
    @vcards = Vcard.find(:all, :origin =>[loc.lat,loc.lng], :within=>params[:vcard][:distance])
    # Find near an address:
    # Store.find(:all, :origin=>'100 Spear st, San Francisco, CA', :within=>10)
    @map = GMap.new("map_div_id")  
    @map.control_init(:large_map => true, :map_type => true)  
    @map.center_zoom_init([loc.lat, loc.lng], 15)  
    markers = []

    @vcards.each do |card|
      if card.eql?(@vcards.first)
        @map.overlay_init(GMarker.new([card.lat, card.lng], :info_window => card.org))
      else        
        @map.overlay_init(GMarker.new([card.lat, card.lng], :info_window => card.org))        
      end
    end
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html 'search_transactions', @map.add_overlay(GMarker.new([12.1,12.76],:title => "Hello again!"))        
        end
      end
    end

  end

  # GET /vcards/1
  # GET /vcards/1.xml
  def show
    @vcard = Vcard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vcard }
    end
  end

  # GET /vcards/new
  # GET /vcards/new.xml
  def new
    @vcard = Vcard.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vcard }
    end
  end

  # GET /vcards/1/edit
  def edit
    @vcard = Vcard.find(params[:id])
  end

  # POST /vcards
  # POST /vcards.xml
  def create
    @vcard = Vcard.new(params[:vcard])

    respond_to do |format|
      if @vcard.save
        flash[:notice] = 'Vcard was successfully created.'
        format.html { redirect_to(@vcard) }
        format.xml  { render :xml => @vcard, :status => :created, :location => @vcard }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vcard.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vcards/1
  # PUT /vcards/1.xml
  def update
    @vcard = Vcard.find(params[:id])

    respond_to do |format|
      if @vcard.update_attributes(params[:vcard])
        flash[:notice] = 'Vcard was successfully updated.'
        format.html { redirect_to(@vcard) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vcard.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vcards/1
  # DELETE /vcards/1.xml
  def destroy
    @vcard = Vcard.find(params[:id])
    @vcard.destroy

    respond_to do |format|
      format.html { redirect_to(vcards_url) }
      format.xml  { head :ok }
    end
  end
end