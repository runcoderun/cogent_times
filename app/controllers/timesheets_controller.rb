class TimesheetsController < ApplicationController
  
  def edit
    redirect_to :action => :index unless person
    @timesheet = Timesheet.new(person, :start_date => start_date)
  end
   
  def update
    key = { :project_id => project_id, :person_id => person_id, :date => date }
    period = WorkPeriod.first(key) || WorkPeriod.new(key)
    period.hours = hours
    period.save
    render :nothing => true
  end
  
  def select
    if person
      redirect_to edit_timesheet_url(person.id)
    else
      redirect_to timesheets_url
    end
  end
   
  def project_total
    render_total(project_work_periods)
  end
  
  def date_total
    render_total(date_work_periods)
  end

  private

  def project_work_periods
    return WorkPeriod.all(:project_id => project_id, :person_id => person_id).select {|work| date_range.include?(work.date)}
  end
  
  def date_work_periods
    return Timesheet.new(person, {:start_date => date, :end_date => date}).work_periods
  end
  
  def hours
    params['hours'].to_f
  end
  
  def date
    params['date'].to_date
  end
  
  def project_id
    params['project_id']
  end
  
  def person
    @person ||= Person.get(person_id)
  end
  
  def person_id
    params['id']
  end  
  
  def render_total(periods)
    pp 'Rendering totals'
    pp periods
    total_hours = periods.empty? ? 0 : periods.sum(&:hours)
    pp "Total hours #{total_hours}"
    respond_to do |format|
      format.js   { render :text => total_hours.to_s }
    end
  end
  
  def person
    @person ||= Person.get(params['id'])
  end
  
  def date_range
    if !@date_range
      start_date = params['start_date'].to_date
      end_date = params['end_date'].to_date
      @date_range = start_date..end_date
    end
    return @date_range
  end
  
  def start_date
    params['start_date'] ? params['start_date'].to_date : Date.today
  end
  
end
