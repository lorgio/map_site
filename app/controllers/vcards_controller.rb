require 'vpim/vcard'

class VcardsController < ApplicationController
  # GET /vcards
  # GET /vcards.xml
  def index
    @vcards = Vcard.find(:all)
    @vcard = Vcard.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vcards }
    end
  end

  def import
    cards = Vpim::Vcard.decode(params[:vcard][:datafile].read)                

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
        title = card['TITLE']
        org = card['ORG']
        org = org.gsub(/\\,/,'.') if org.kind_of?(String)
        url = card['URL']
        notes = card['NOTE']

        vcard1 = Vcard.create :first_name => first_name,
                              :last_name  => last_name,
                              :org        => org,
                              :work_phone => work_phone,
                              :home_phone => home_phone,
                              :url        => url,
                              :street     => street, 
                              :city       => city, 
                              :state      => state, 
                              :zip_code   => zip_code, 
                              :country    => country
      end

    end

    respond_to do |format|
      flash[:notice] = 'Vcard was successfully created.'
      format.html { redirect_to(vcards_url) }
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