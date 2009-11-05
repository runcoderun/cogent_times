class SecureController < ApplicationController

  before_filter :login_required
  
  def login_required
    if session[:user_id]
      @user ||= User.get(session[:user_id])
      # @access_token ||= OAuth::AccessToken.new(get_consumer, @user.oauth_token, @user.oauth_secret)
    elsif ENV["RAILS_ENV"] == "development" || skip_authentication?
      @user = User.first
    else
      redirect_to :controller => 'session', :action => 'new'
    end
  end

  private
  
  def skip_authentication?
    false
  end
    
end
