class WorkPeriodsController < ApplicationController

  resources_controller_for :work_periods
  
  def create
    reformat_params
    super
  end
  
  def update
    reformat_params
    super
  end
  
  private

  def reformat_params
    reformat_date
    reformat_hours
    reformat_person
    reformat_project
  end

  def date
    return self.params['work_period']['date'].to_date
  end
  
  def person_id
    return self.params['work_period']['person'].to_i
  end
  
  def reformat_person
    self.params['work_period']['person'] = Person.get(person_id)
  end
  
  def project_id
    return self.params['work_period']['project'].to_i
  end
  
  def reformat_project
    self.params['work_period']['project'] = Project.get(project_id)
  end
  
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
    return if params[object][property] # already formatted
    year_key = "#{property}(1i)"
    month_key = "#{property}(2i)"
    day_key = "#{property}(3i)"
    value = Date.civil(params[object][year_key].to_i,params[object][month_key].to_i,params[object][day_key].to_i)
    self.params[object].delete(year_key)
    self.params[object].delete(month_key)
    self.params[object].delete(day_key)
    self.params[object][property] = value
  end
  
end
