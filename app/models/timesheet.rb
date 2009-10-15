class Timesheet
  
  attr_reader :start_date, :end_date
  
  def initialize(person, options={})
    start_date = options[:start_date]
    end_date = options[:end_date]
    @project = options[:project]
    @person = person
    @start_date = start_date || Date.today
    @end_date = end_date || 6.days.from_now(start_date)
  end
  
  def work_periods
    keys = { :person_id => person_id }
    keys[:project_id] = @project.id if @project
    periods = WorkPeriod.all(keys)
    periods = periods.select {|p| date_range.include?(p.date)} if date_range
    return periods
  end
  
  def person_name
    @person.full_name
  end
  
  def person_id
    @person.id
  end
  
  def date_range
    return start_date..end_date if start_date && end_date
  end
  
  def work(project, date)
    return 0
  end
  
  def date_total(date)
    return 0
  end
  
  def total
    return 0
  end
  
  def project_total(project)
    return 0
  end
  
end