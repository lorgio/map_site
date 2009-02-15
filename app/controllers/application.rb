# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  before_filter :set_iphone_format
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'dd868d56c85893687304477cb8e352e7'
  
  def is_iphone_request?
    request.user_agent =~ /(Mobile\/.+Safari)/
  end
  

    
    def set_iphone_format
      if is_iphone_request?
        request.format = :iphone
        redirect_to :controller => "iphone", :action => "index"
      end
    end
    
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
