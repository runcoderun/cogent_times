#"curl -u steve.hayes@cogentconsulting.com.au:westberlin -X GET https://www.pivotaltracker.com/services/tokens/active"
require 'open-uri'
require 'openssl'
require 'rubygems'
require 'hpricot'
# require 'pivotal-tracker'

class CogentPivotalTracker

  delegate :stories, :activities, :to => :pivotal_tracker

  def initialize(project_id)
    @project_id = project_id
  end
  
  private
  
  def token
    @token ||= new_token
  end

  def pivotal_tracker
    @pivotal_tracker ||= ::PivotalTracker::PivotalTracker.new(@project_id, token)
  end
  
  def turn_off_certificate_checking
    return if OpenSSL::SSL::VERIFY_PEER == OpenSSL::SSL::VERIFY_NONE
    OpenSSL::SSL.const_set(:VERIFY_PEER, OpenSSL::SSL::VERIFY_NONE) # can use a symbol
  end
  
  def new_token
    turn_off_certificate_checking
    token_provider = "https://www.pivotaltracker.com/services/tokens/active"
    login_details = ["steve.hayes@cogentconsulting.com.au", "westberlin"]
    puts 'Getting token'
    token = nil
    open(token_provider, :http_basic_authentication => login_details) do |f|
      doc = Hpricot::XML(f.string)
      token = (doc/:token).first.at('guid').innerHTML
    end  
    puts "token = #{token}"
    return token
  end
  
end  
