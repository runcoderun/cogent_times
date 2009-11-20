require 'xmlsimple'
require 'oauth/consumer'
require 'oauth/signature/rsa/sha1'

class SessionController < ApplicationController
  
  def index
    redirect_to :controller => 'home' if session[:user_id]
  end
  
  def new
    consumer = get_consumer
    request_token = consumer.get_request_token( {:oauth_callback => create_session_url}, {:scope => "https://www.google.com/m8/feeds/"})
    session[:oauth_secret] = request_token.secret
    redirect_to request_token.authorize_url
  end
 
  def create
    access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
    xml = ::XmlSimple.xml_in(access_token.get("https://www.google.com/m8/feeds/contacts/default/full/").body)
    update_user(xml, access_token)
    user = updated_user(xml, access_token)
    session[:user_id] = user.id
    redirect_to post_authentication_url
  end
 
  def delete
    reset_session
    redirect_to root_url
  end
  
  private

  def updated_user(xml, access_token)
    user = User.first(:email => email_from(xml))
    user.name = name_from(xml)
    user.oauth_token  =  access_token.token
    user.oauth_secret =  access_token.secret
    user.save
    return user
  end
  
  def request_token
    OAuth::RequestToken.new(get_consumer, params[:oauth_token], session[:oauth_secret])
  end
  
  def email_from(xml)
    xml["author"].first["email"].first
  end

  def name_from(xml)
    xml["author"].first["name"].first
  end
  
  def get_consumer
    return OAuth::Consumer.new(oath_consumer_key, oauth_consumer_secret, oauth_consumer_options)
  end

  def oauth_consumer_options
    { :site => "https://www.google.com",
      :request_token_path => "/accounts/OAuthGetRequestToken",
      :access_token_path => "/accounts/OAuthGetAccessToken",
      :authorize_path=> "/accounts/OAuthAuthorizeToken",
      :signature_method => "RSA-SHA1",
      :private_key_file => "#{RAILS_ROOT}/config/rsakey.pem" }
  end
  
end