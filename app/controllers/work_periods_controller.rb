class WorkPeriodsController < ApplicationController

  resources_controller_for :work_periods
  
  alias base_create create
  alias base_update update

  def create
    reformat_date
    reformat_hours
    base_create
  end
  
  def update
    reformat_date
    reformat_hours
    base_update
  end
  
  private
  
  def reformat_date
    make_param_date('work_period', 'date')
  end

  def reformat_hours
    make_param_float('work_period', 'hours')
  end
  
  def make_param_float(object, property)
    value = params[object][property].to_f
    params[object][property] = value
  end
  
  def make_param_date(object, property)
    year_key = "#{property}(1i)"
    month_key = "#{property}(2i)"
    day_key = "#{property}(3i)"
    value = Date.civil(params[object][year_key].to_i,params[object][month_key].to_i,params[object][day_key].to_i)
    params[object].delete(year_key)
    params[object].delete(month_key)
    params[object].delete(day_key)
    params[object][property] = value
  end
  
end
