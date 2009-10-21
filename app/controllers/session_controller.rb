require 'xmlsimple'

class SessionController < ApplicationController
  skip_before_filter :login_required, :only => [:new, :create]
 
  def new
    consumer = get_consumer
    request_token = consumer.get_request_token( {:oauth_callback => post_authentication_url}, {:scope => "https://www.google.com/m8/feeds/"})
    session[:oauth_secret] = request_token.secret
    redirect_to request_token.authorize_url
  end
 
  def create
    request_token = OAuth::RequestToken.new(get_consumer, params[:oauth_token], session[:oauth_secret])
    access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
    xml = ::XmlSimple.xml_in(access_token.get("https://www.google.com/m8/feeds/contacts/default/full/").body)
    email = xml["author"].first["email"].first
    user = User.first(:email => email)
    user.name = xml["author"].first["name"].first
    user.oauth_token  =  access_token.token
    user.oauth_secret =  access_token.secret
    user.save
    session[:user_id] = user.id
    redirect_to timesheets_url
  end
 
  def delete
    reset_session
    flash[:notice] = "You have been logged out"
    redirect_to :action => 'new'
  end
end