class TimesheetChecksController < SecureController
  
  def index
    @timesheet_check = TimesheetCheck.new(date)
  end

  private
  
  def date
    params['date'] ? params['date'].to_date : Date.today
  end
  
end