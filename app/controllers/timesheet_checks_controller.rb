class TimesheetChecksController < SecureController
  
  def index
    @timesheet_check = TimesheetCheck.new(date)
    @message = params[:message] || ''
  end

  def reminder
    person = Person.get(params[:id])
    Reminder.deliver_missing_hours(person, params[:date].to_date)
    redirect_to timesheet_checks_url(:date => params[:date], :message => "Reminder was sent to #{person.email}")
  end
  
  private
  
  def date
    params['date'] ? params['date'].to_date : Date.today
  end
  
end