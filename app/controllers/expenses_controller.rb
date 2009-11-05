class ExpensesController < SecureController

  resources_controller_for :expenses, :in => :project

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
    reformat_project
    reformat_date
  end

  def project_id
    return self.params['expense']['project_id'].to_i
  end
  
  def reformat_project
    self.params['expense']['project'] = Project.get(project_id)
  end
  
  def reformat_date
    extract_date_select_value('expense', 'date')
  end

end
