class WorkPeriodsController < SecureController

  resources_controller_for :work_periods
  
  def create
    reformat_params
    super
  end
  
  def update
    reformat_params
    super
  end
  
  def cleanup
    WorkPeriod.cleanup
    redirect_to :controller => :home
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
    extract_date_select_value('work_period', 'date')
  end

  def reformat_hours
    make_param_float('work_period', 'hours')
  end
  
end
