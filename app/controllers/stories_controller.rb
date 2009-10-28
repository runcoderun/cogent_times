class StoriesController < SecureController
  # resources_controller_for :stories
  resources_controller_for :stories, :in => :project

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
  end

  def project_id
    return self.params['story']['project_id'].to_i
  end
  
  def reformat_project
    self.params['story']['project'] = Project.get(project_id)
  end
  
end
