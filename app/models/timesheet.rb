class Timesheet
  
  attr_reader :start_date, :end_date, :date_range
  
  def initialize(person, options={})
    @project = options[:project]
    @person = person
    @date_range = options[:date_range]
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