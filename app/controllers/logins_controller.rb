require 'googleauthsub'

class LoginsController < ApplicationController

  def show
    login
  end

  def new
    assign_token_from_params
    redirect_to timesheets_url
  end

  def destroy
    revoke_token
    redirect_to login_url
  end
  
end
