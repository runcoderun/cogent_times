class StatusChangesController < SecureController

  def index
    @project_id = params[:project_id]
    @status_changes = Project.get(params[:project_id]).status_changes
  end

end
