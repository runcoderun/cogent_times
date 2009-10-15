class Timesheet
  
  attr_reader :date_range
  
  def initialize(person, options={})
    @person = person
    @project = options[:project]
    @date_range = options[:date_range]
  end
  
  def person_name
    @person.full_name
  end
  
  def person_id
    @person.id
  end
  
  def work(project, date)
    return Timesheet.new(@person, :project => project, :date_range => date..date).total
  end
  
  def date_total(date)
    return Timesheet.new(@person, :date_range => date..date).total
  end
  
  def total
    work_periods.empty? ? 0 : work_periods.sum(&:hours)  
  end
  
  def project_total(project)
    return Timesheet.new(@person, :project => project, :date_range => @date_range).total
  end

  private
  
  def work_periods
    @work_periods ||= get_work_periods
  end
  
  def get_work_periods
    keys = { :person_id => person_id }
    keys[:project_id] = @project.id if @project
    periods = WorkPeriod.all(keys)
    periods = periods.select {|p| date_range.include?(p.date)} if @date_range
    return periods
  end
  
end