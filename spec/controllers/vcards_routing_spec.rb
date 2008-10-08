require File.dirname(__FILE__) + '/../spec_helper'

describe VcardsController do
  describe "route generation" do

    it "should map { :controller => 'vcards', :action => 'index' } to /vcards" do
      route_for(:controller => "vcards", :action => "index").should == "/vcards"
    end
  
    it "should map { :controller => 'vcards', :action => 'new' } to /vcards/new" do
      route_for(:controller => "vcards", :action => "new").should == "/vcards/new"
    end
  
    it "should map { :controller => 'vcards', :action => 'show', :id => 1 } to /vcards/1" do
      route_for(:controller => "vcards", :action => "show", :id => 1).should == "/vcards/1"
    end
  
    it "should map { :controller => 'vcards', :action => 'edit', :id => 1 } to /vcards/1/edit" do
      route_for(:controller => "vcards", :action => "edit", :id => 1).should == "/vcards/1/edit"
    end
  
    it "should map { :controller => 'vcards', :action => 'update', :id => 1} to /vcards/1" do
      route_for(:controller => "vcards", :action => "update", :id => 1).should == "/vcards/1"
    end
  
    it "should map { :controller => 'vcards', :action => 'destroy', :id => 1} to /vcards/1" do
      route_for(:controller => "vcards", :action => "destroy", :id => 1).should == "/vcards/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'vcards', action => 'index' } from GET /vcards" do
      params_from(:get, "/vcards").should == {:controller => "vcards", :action => "index"}
    end
  
    it "should generate params { :controller => 'vcards', action => 'new' } from GET /vcards/new" do
      params_from(:get, "/vcards/new").should == {:controller => "vcards", :action => "new"}
    end
  
    it "should generate params { :controller => 'vcards', action => 'create' } from POST /vcards" do
      params_from(:post, "/vcards").should == {:controller => "vcards", :action => "create"}
    end
  
    it "should generate params { :controller => 'vcards', action => 'show', id => '1' } from GET /vcards/1" do
      params_from(:get, "/vcards/1").should == {:controller => "vcards", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'vcards', action => 'edit', id => '1' } from GET /vcards/1;edit" do
      params_from(:get, "/vcards/1/edit").should == {:controller => "vcards", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'vcards', action => 'update', id => '1' } from PUT /vcards/1" do
      params_from(:put, "/vcards/1").should == {:controller => "vcards", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'vcards', action => 'destroy', id => '1' } from DELETE /vcards/1" do
      params_from(:delete, "/vcards/1").should == {:controller => "vcards", :action => "destroy", :id => "1"}
    end
  end
end