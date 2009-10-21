require 'xmlsimple'
require 'oauth/consumer'
require 'oauth/signature/rsa/sha1'

class SessionController < ApplicationController
  
  def new
    consumer = get_consumer
    request_token = consumer.get_request_token( {:oauth_callback => create_session_url}, {:scope => "https://www.google.com/m8/feeds/"})
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
    redirect_to post_authentication_url
  end
 
  def delete
    reset_session
    redirect_to 'home_index_url'
  end
  
  private
  
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