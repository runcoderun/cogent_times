require 'date_extensions'

class TimesheetsController < SecureController
  
  def edit
    redirect_to :action => :index unless person
    @timesheet = Timesheet.new(person, :date_range => start_date..end_date)
  end
   
  def update
    puts 'In update'
    pp params 
    key = { :project_id => project_id, :person_id => person_id, :date => date }
    period = WorkPeriod.first(key) || WorkPeriod.new(key)
    require 'pp'
    pp period 
    period.hours = hours
    period.save
    pp period 
    pp period.errors
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
    render_total(project_work_hours)
  end
  
  def date_total
    render_total(date_work_hours)
  end

  def total
    render_total(work_hours)
  end

  private

  def work_hours
    return Timesheet.new(person, :date_range => start_date..end_date).total
  end
  
  def project_work_hours
    return Timesheet.new(person, :project => project, :date_range => start_date..end_date).total
  end
  
  def date_work_hours
    return Timesheet.new(person, :date_range => date..date).total
  end
  
  def hours
    params['hours'].to_f
  end
  
  def date
    params['date'].to_date
  end
  
  def project
    Project.get(project_id)
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
  
  def render_total(hours)
    respond_to do |format|
      format.js   { render :text => hours.to_s }
    end
  end
  
  def person
    @person ||= Person.get(params['id'])
  end
  
  def date_range
    @date_range ||= start_date..end_date
  end

  def end_date
    params['end_date'] ? params['end_date'].to_date : 6.days.from_now(start_date)
  end
  
  def start_date
    params['start_date'] ? params['start_date'].to_date : (params['end_date'] ? params['end_date'].to_date - 6 : default_start_date)
  end
  
  def default_start_date
    return Date.today.start_of_week
  end
  
end
