class ProjectDashboardsController < SecureController
  
  require 'pp'
  
  include DateRangeSelection

  def select
    constraints = { :start_date => selected_start_date, :end_date => selected_end_date , :project_id => params[:project_id]}
    redirect_to project_project_dashboard_url(constraints)
  end
  
  def show
    pp params
    @project = Project.get(params[:project_id])
    @start_date = start_date
    @end_date = end_date
    @statuses = @project.latest_statuses_in(start_date..end_date)
    @billings = Billings.new([@project], start_date, end_date)
    @status_summary = @statuses.group_by(&:status)
  end
  
end
