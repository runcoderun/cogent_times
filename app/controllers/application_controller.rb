# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require 'oauth/consumer'
require 'oauth/signature/rsa/sha1'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def skip_authentication?
    false
  end
  
  def login_required
    if session[:user_id]
      @user ||= User.get(session[:user_id])
      # @access_token ||= OAuth::AccessToken.new(get_consumer, @user.oauth_token, @user.oauth_secret)
    elsif skip_authentication?
      @user = User.first
    else
      redirect_to :controller => 'session', :action => 'new'
    end
  end

  
  def get_consumer
    return OAuth::Consumer.new(oath_consumer_key, oauth_consumer_secret, oauth_consumer_options)
  end

  private
  
  def post_authentication_url
    'http://localhost:3000/session/create'
  end
  
  def oath_consumer_key
    'cogent-times.heroku.com'
  end
  
  def oauth_consumer_secret
    'UYAvgbsvem0R5ZYaxm7gmmK0'
  end
  
  def oauth_consumer_options
    { :site => "https://www.google.com",
      :request_token_path => "/accounts/OAuthGetRequestToken",
      :access_token_path => "/accounts/OAuthGetAccessToken",
      :authorize_path=> "/accounts/OAuthAuthorizeToken",
      :signature_method => "RSA-SHA1",
      :private_key_file => "#{RAILS_ROOT}/config/rsakey.pem" }
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
