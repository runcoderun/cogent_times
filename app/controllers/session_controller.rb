require 'pp'
require 'xmlsimple'

class SessionController < ApplicationController
  skip_before_filter :login_required, :only => [:new, :create]
 
  def new
    puts 'in new action of session controller'
    puts 'look in session'
    session[:dummy] = ''
    pp session
    consumer = get_consumer
    pp session
    next_url = 'http://localhost:3000/session/create'
    pp session
    request_token = consumer.get_request_token( {:oauth_callback => next_url}, {:scope => "https://www.google.com/m8/feeds/"})
    pp session
    puts 'setting session[:oauth_secret] of session controller'
    pp session
    session[:oauth_secret] = request_token.secret
    session[:oauth_token] = request_token.token
    # session[:request_token] = request_token
    puts 'redirecting'
    pp session
    redirect_to request_token.authorize_url# + "&oauth_callback=#{next_url}"
  end
 
  def create
    puts 'in session#create'
    pp params
    session[:dummy] = ''
    # {"action"=>"create",
    #  "oauth_token"=>"4/9UTSIB1JcsIBIR_mBs2Uq_b_CbLU",
    #  "oauth_verifier"=>"Sb6ibDXEYux7GmigIyElvp6P",
    #  "controller"=>"session"}
    pp session
    pp params[:oauth_token]
    pp session[:oauth_secret]
    request_token = OAuth::RequestToken.new(get_consumer, params[:oauth_token], session[:oauth_secret])
    access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
    puts 'about to call for xml'
    xml = ::XmlSimple.xml_in(access_token.get("https://www.google.com/m8/feeds/contacts/default/full/").body)
    puts 'got xml'
    email = xml["author"].first["email"].first
    puts 'email = ', email.to_s
    user = User.find_or_create_by_email(email)
    user.name = xml["author"].first["name"].first
    user.oauth_token  =  access_token.token
    user.oauth_secret =  access_token.secret
     user.save
    session[:user_id] = user.id
    redirect_to :controller => 'account'
  end
 
  def delete
    reset_session
    flash[:notice] = "You have been logged out"
    redirect_to :action => 'new'
  end
end