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
  
  def synchronise
    @project.synchronise_with_pivotal
    redirect_to project_stories_url, :project_id => @project.id
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
