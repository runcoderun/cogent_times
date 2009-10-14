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
   
  def update
    require 'pp'
    pp params
    date = params['date'].to_date
    key = { :project_id => params['project_id'], :person_id => params['id'], :date => date }
    period = WorkPeriod.first(key) || WorkPeriod.new(key)
    period.hours = params['hours'].to_f
    period.save
  end
  
  def project_total
    require 'pp'
    pp params
    start_date = params['start_date'].to_date
    end_date = params['end_date'].to_date
    date_range = start_date..end_date
    # change this to be a date range
    periods = WorkPeriod.all(:project_id => params['project_id'], :person_id => params['id']).select {|work| date_range.include?(work.date)}
    total_hours = periods.empty? ? 0 : periods.sum(&:hours)
    pp total_hours
    respond_to do |format|
      format.js   { render :text => total_hours.to_s }
    end
  end
  
end
