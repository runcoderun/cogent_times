class ProjectCostsController < SecureController
  
  resources_controller_for :projects
  
  def index
    @date = params['date'] ? params['date'].to_date : Date.today
    super
  end
  
end
