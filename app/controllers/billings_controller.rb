require 'date_extensions'

class BillingsController < SecureController
  
  include DateRangeSelection
  
  def index
    projects = Project.all.select{|project| project.use_in_reports}
    @billings = Billings.new(Project.all, start_date, end_date)
  end
  
  def select_date_range
    redirect_to billings_url(:start_date => selected_start_date, :end_date => selected_end_date)
  end
  
end
