class TimesheetsController < ApplicationController
  
  def select
    if Person.get(params['id'])
      redirect_to edit_timesheet_url(params['id'])
    else
      redirect_to timesheets_url
    end
  end
   
  def edit
    person = Person.get(params['id'])
    redirect_to :action => :index unless person
    start_date = Date.today
    @timesheet = Timesheet.new(person, start_date)
  end
   
end
