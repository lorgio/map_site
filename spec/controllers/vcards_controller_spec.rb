require File.dirname(__FILE__) + '/../spec_helper'

describe VcardsController do
  describe "handling GET /vcards" do

    before(:each) do
      @vcard = mock_model(Vcard)
      Vcard.stub!(:find).and_return([@vcard])
    end
  
    def do_get
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all vcards" do
      Vcard.should_receive(:find).with(:all).and_return([@vcard])
      do_get
    end
  
    it "should assign the found vcards for the view" do
      do_get
      assigns[:vcards].should == [@vcard]
    end
  end

  describe "handling GET /vcards.xml" do

    before(:each) do
      @vcards = mock("Array of Vcards", :to_xml => "XML")
      Vcard.stub!(:find).and_return(@vcards)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all vcards" do
      Vcard.should_receive(:find).with(:all).and_return(@vcards)
      do_get
    end
  
    it "should render the found vcards as xml" do
      @vcards.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /vcards/1" do

    before(:each) do
      @vcard = mock_model(Vcard)
      Vcard.stub!(:find).and_return(@vcard)
    end
  
    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template('show')
    end
  
    it "should find the vcard requested" do
      Vcard.should_receive(:find).with("1").and_return(@vcard)
      do_get
    end
  
    it "should assign the found vcard for the view" do
      do_get
      assigns[:vcard].should equal(@vcard)
    end
  end

  describe "handling GET /vcards/1.xml" do

    before(:each) do
      @vcard = mock_model(Vcard, :to_xml => "XML")
      Vcard.stub!(:find).and_return(@vcard)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the vcard requested" do
      Vcard.should_receive(:find).with("1").and_return(@vcard)
      do_get
    end
  
    it "should render the found vcard as xml" do
      @vcard.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /vcards/new" do

    before(:each) do
      @vcard = mock_model(Vcard)
      Vcard.stub!(:new).and_return(@vcard)
    end
  
    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create an new vcard" do
      Vcard.should_receive(:new).and_return(@vcard)
      do_get
    end
  
    it "should not save the new vcard" do
      @vcard.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new vcard for the view" do
      do_get
      assigns[:vcard].should equal(@vcard)
    end
  end

  describe "handling GET /vcards/1/edit" do

    before(:each) do
      @vcard = mock_model(Vcard)
      Vcard.stub!(:find).and_return(@vcard)
    end
  
    def do_get
      get :edit, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the vcard requested" do
      Vcard.should_receive(:find).and_return(@vcard)
      do_get
    end
  
    it "should assign the found Vcard for the view" do
      do_get
      assigns[:vcard].should equal(@vcard)
    end
  end

  describe "handling POST /vcards" do

    before(:each) do
      @vcard = mock_model(Vcard, :to_param => "1")
      Vcard.stub!(:new).and_return(@vcard)
    end
    
    describe "with successful save" do
  
      def do_post
        @vcard.should_receive(:save).and_return(true)
        post :create, :vcard => {}
      end
  
      it "should create a new vcard" do
        Vcard.should_receive(:new).with({}).and_return(@vcard)
        do_post
      end

      it "should redirect to the new vcard" do
        do_post
        response.should redirect_to(vcard_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @vcard.should_receive(:save).and_return(false)
        post :create, :vcard => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /vcards/1" do

    before(:each) do
      @vcard = mock_model(Vcard, :to_param => "1")
      Vcard.stub!(:find).and_return(@vcard)
    end
    
    describe "with successful update" do

      def do_put
        @vcard.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the vcard requested" do
        Vcard.should_receive(:find).with("1").and_return(@vcard)
        do_put
      end

      it "should update the found vcard" do
        do_put
        assigns(:vcard).should equal(@vcard)
      end

      it "should assign the found vcard for the view" do
        do_put
        assigns(:vcard).should equal(@vcard)
      end

      it "should redirect to the vcard" do
        do_put
        response.should redirect_to(vcard_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @vcard.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /vcards/1" do

    before(:each) do
      @vcard = mock_model(Vcard, :destroy => true)
      Vcard.stub!(:find).and_return(@vcard)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the vcard requested" do
      Vcard.should_receive(:find).with("1").and_return(@vcard)
      do_delete
    end
  
    it "should call destroy on the found vcard" do
      @vcard.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the vcards list" do
      do_delete
      response.should redirect_to(vcards_url)
    end
  end
end