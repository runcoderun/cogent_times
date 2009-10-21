# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def post_authentication_url
    timesheets_url
  end
  
  def post_logout_url
    home_url
  end
  
  def private_key_path
    "#{RAILS_ROOT}/config/rsakey.pem"
  end
  
  def oath_consumer_key
    'cogent-times.heroku.com'
  end
  
  def oauth_consumer_secret
    'UYAvgbsvem0R5ZYaxm7gmmK0'
  end
  
    # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  # def rescue_action(exception)
  #   case exception
  #   when ActiveRecord::RecordNotFound
  #     respond_with_404
  #   when ActiveRecord::RecordInvalid
  #     respond_with_422(exception.record)
  #   else          
  #     super
  #   end
  # end
  # 
  # def respond_with_422(record)
  #   respond_to do |format|
  #     format.html { render :action => (record.new_record? ? 'new' : 'edit') }
  #     format.xml  { render :xml => record.errors.to_xml, :status => 422 }
  #     format.js   { render :json => record.errors.to_json, :status => 422 }
  #   end
  # end
  
end
