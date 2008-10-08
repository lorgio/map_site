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
      # nickname = card['NICKNAME']

      # Depending on contact Evolution used different types for email field
      # In my case order of importance for emails was as below.
      # Luckily no contact have had more than two emails
      # raise card['EMAIL', 'INTERNET'].to_yaml
      # email_internet = card['EMAIL', 'INTERNET']
      # email_work = card['EMAIL', 'WORK']
      # email_home = card['EMAIL', 'HOME']
      # email_other = card['EMAIL', 'OTHER']
      # emails = []
      # [email_internet, email_work, email_home, email_other].each {|email| email && emails << email}

      home_phone = card['TEL', 'HOME']
      work_phone = card['TEL', 'WORK']
      
      # tel_fax = card['TEL', 'FAX']
      # tel_mobile = card['TEL', 'CELL']
      # address = card['ADR', 'HOME']
      # address = address.gsub(/\\,/,'.') if address.kind_of?(String)
      address_work = card['ADR', 'WORK']
      address_work = address_work.gsub(/\\,/,'.') if address_work.kind_of?(String)

      title = card['TITLE']
      # organization = card['ORG']
      org = card['ORG']
      org = org.gsub(/\\,/,'.') if org.kind_of?(String)
      url = card['URL']
      notes = card['NOTE']

      # Full list of fields:
      ##{address},,,,,,#{address_work},,,,
      # first,last,display,nickname,email,add email,work phone,home phone,fax,pager,mobile,address,address2,city,state,zip,country,address work,address work2,city work,state work,zip work,country work,title,departament,organization,http://web page work,http://web page,,,,custom 1,custom 2,custom 3,custom 4,notes,

      # logger.debug  "#{first_name}, #{last_name},#{full_name},#{work_phone},#{home_phone},#{title},,#{org},,#{url},,,,,,,,#{notes}," 
      # logger.debug { "#{card.to_yaml}" }
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

  #################################################################################  
  def get_contact
    contact = Address.find(params[:id])
    company = OfficeAddress.find(contact.office_address_id)

    card = Vpim::Vcard::Maker.make2 do |maker|

      maker.add_name do |name|
        name.given = contact.firstname + ' ' + contact.lastname
      end

      maker.add_addr do |addr|
        addr.location = ‘home’
        addr.street = contact.street
        addr.locality = contact.area
        addr.region = contact.state
        addr.postalcode = contact.pin
        addr.country = contact.country
      end

      maker.add_addr do |addr|
        addr.location = ‘work’
        addr.street = company.street
        addr.locality = company.area
        addr.region = company.state
        addr.postalcode = company.pin
        addr.country = company.country
      end

      if !contact.ph_resi.empty?
        maker.add_tel(contact.ph_resi) do |tel|
          tel.location = ‘home’
          tel.preferred = true
        end
      end

      if !contact.ph_office.empty?
        phone = contact.ph_office
        maker.add_tel(phone) do |tel|
          tel.location = ‘work’
          tel.preferred = true
        end
      end

      if !contact.fax.empty?
        maker.add_tel(contact.fax) do |tel|
          tel.location = ‘work’
          tel.capability = ‘fax’
        end
      end

      if !contact.mobile.empty?
        maker.add_tel(contact.mobile) do |tel|
          tel.location = ‘home’
          tel.capability = ‘mobile’
        end
      end

      maker.add_email(contact.email) do |e|
        e.location = ‘work’
      end

    end

    send_data card.to_s,
    :filename => “contact.vcf”
  end


end