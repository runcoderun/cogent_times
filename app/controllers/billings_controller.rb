require 'date_extensions'

class BillingsController < SecureController
  
  def index
    projects = Project.all.select{|project| project.use_in_reports}
    start_date = params['start_date'] ? params['start_date'].to_date : default_start_date
    end_date = params['end_date'] ? params['end_date'].to_date : default_end_date
    @billings = Billings.new(Project.all, start_date, end_date)
  end
  
  def select_date_range
    redirect_to billings_url(:start_date => start_date, :end_date => end_date)
  end
  
  private
  
  def start_date
    params['start_date'] ? extract_select_date_value('start_date') : default_start_date
  end
  
  def end_date
    params['end_date'] ? extract_select_date_value('end_date') : default_end_date
  end
  
  def default_start_date
    Date.today.start_of_month
  end
  
  def default_end_date
    Date.today.end_of_month
  end
  
end
