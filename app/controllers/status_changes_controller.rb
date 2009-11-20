class StatusChangesController < SecureController

  require 'pp'
  
  include DateRangeSelection

  def select
    pp params
    constraints = { :start_date => selected_start_date, :end_date => selected_end_date , :project_id => params[:project_id]}
    redirect_to project_status_changes_url(constraints)
  end
  
  def index
    pp params
    @project_id = params[:project_id]
    @status_changes = Project.get(params[:project_id]).status_changes
  end

end
