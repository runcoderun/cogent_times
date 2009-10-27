# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def logged_in?
    return session[:user_id] || ENV["RAILS_ENV"] == "development"
  end
  
end
