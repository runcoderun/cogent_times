class AssignmentsController < SecureController

  resources_controller_for :assignments
  
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
    reformat_rate
    reformat_person
    reformat_project
  end

  def person_id
    return self.params['assignment']['person_id'].to_i
  end
  
  def reformat_person
    self.params['assignment']['person'] = Person.get(person_id)
  end
  
  def project_id
    return self.params['assignment']['project_id'].to_i
  end
  
  def reformat_project
    self.params['assignment']['project'] = Project.get(project_id)
  end
  
  def reformat_rate
    make_param_float('assignment', 'rate')
  end
  
end
