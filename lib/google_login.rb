# 1. Create your GoogleAuthSub object with :session => true.
#      auth = GoogleAuthSub.new(:next_url => "www.example.com/next", 
#         :scope_url => "http://www.google.com/calendar/feeds", 
#         :session => true)
# 
# 2,3 as per previous example
# 
# 2. Redirect the user to the Google sign in page. request_url gives us the correct url to go to.
#         In rails: 
#             redirect_to auth.request_url
# 
# 3. Once the user has successfully logged in they will then be redirected back to the url specified
#     as the :next_url in step 1. In the handler for this the token needs to be extracted.
#     To do this call: 
#         auth.receive_token(url) 
#     or in rails just do: 
#         auth.token=params[:token]
# 
# 4. Exchange the single use token for a session token.
#     auth.request_session_token
#     NOTE: this has changed from the previous version, which was confusingly named session_token.
#     
# 5. Make requests with auth.get and auth.put.

require 'googleauthsub'

module GoogleLogin
  
  def login_required
    puts 'login required'
    if !self.logged_in?
      redirect_to login_url unless self.logged_in? 
    else
      puts 'did not redirect'
    end
  end
  
  def logged_in?
    puts 'logged_in?'
    puts 'auth.token = ' + auth.token.to_s
    return !!self.auth.token
  end

  def bypass_security
    false
  end
  
  def login
    puts 'login'
    if bypass_security
      puts 'security bypassed'
      puts 'assigning dummy token'
      self.auth.token = 'dummy token'
      puts self.auth.token
      puts !!self.auth.token
      redirect_to timesheets_url
    else
      puts 'security invoked'
      redirect_to_login_page
    end
  end
  
  def auth
    session[:auth] ||= 
      GData::GoogleAuthSub.new(:next_url => new_login_url, 
        :scope_url => "http://www.google.com/calendar/feeds", # what's this for?
        :session => true)
  end

  def assign_token_from_params
    self.auth.token = params[:token]
  end

  def revoke_token
    auth.revoke_token
    auth.token = nil
  end
  
  def redirect_to_login_page
    puts 'redirecting'
    puts 'redirecting to ' + auth.request_url.to_s
    redirect_to auth.request_url.to_s
  end
  
end 
