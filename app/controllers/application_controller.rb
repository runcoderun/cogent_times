# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def post_authentication_url
    timesheets_url
  end
  
  def post_logout_url
    home_url
  end
  
  def private_key_path
    "#{RAILS_ROOT}/config/rsakey.pem"
  end
  
  def oath_consumer_key
    'cogent-times.heroku.com'
  end
  
  def oauth_consumer_secret
    'UYAvgbsvem0R5ZYaxm7gmmK0'
  end
  
  def extract_date_select_value(object, attribute)
    if !self.params[object][attribute]
      self.params[object][attribute] = date_from_date_select_tag(object, attribute)
    end
    return self.params[object][attribute]
  end
  
  def extract_select_date_value(attribute)
    if self.params[attribute].class != Date
      self.params[attribute] = date_from_select_date_field(attribute)
    end
    return self.params[attribute]
  end
  
  def make_param_float(object, property)
    value = params[object][property].to_f
    params[object][property] = value
  end
  
  private
  
  def date_from_select_date_field(attribute)
    Date.civil(params[attribute]['year'].to_i,params[attribute]['month'].to_i,params[attribute]['day'].to_i)
  end
  
  def date_from_date_select_tag(object, attribute)
    year_key = "#{attribute}(1i)"
    month_key = "#{attribute}(2i)"
    day_key = "#{attribute}(3i)"
    year = self.params[object].delete(year_key).to_i
    month = self.params[object].delete(month_key).to_i
    day = self.params[object].delete(day_key).to_i
    return Date.civil(year,month,day)
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
