class Billings
  
  attr_reader :start_date, :end_date
  
  def initialize(projects, start_date, end_date)
    @projects = projects
    @start_date = start_date
    @end_date = end_date
    @timesheets_by_project = {}
    initialize_timesheets
  end
  
  def projects
    @timesheets_by_project.keys.sort_by{|project| project.name.downcase}
  end
     
  def timesheets_for(project)
    @timesheets_by_project[project]
  end
  
  def timesheets_for_category(project_category)
    project_category.projects.collect {|project| self.timesheets_for(project) || []}.flatten
  end
  
  def hours
    @hours ||= timesheets.sum &:hours
  end
  
  def reportable_hours
    timesheets.select{|timesheet| timesheet.project.use_in_reports}.sum &:hours
  end
  
  def billing
    timesheets.sum &:billing
  end
  
  def costs
    timesheets.sum &:costs
  end
  
  def margin
    timesheets.sum &:margin
  end
  
  private
  
  def initialize_timesheets
    @projects.each do |project|
      timesheets = project.people.sort_by{|person| person.full_name}.collect {|person| BillingTimesheet.new(project, person, @start_date..@end_date)}.reject {|timesheet| timesheet.total == 0}
      @timesheets_by_project[project] = timesheets unless timesheets.empty?
    end
  end
  
  def timesheets
    @timesheets_by_project.values.flatten
  end
  
end

class BillingTimesheet
  
  attr_reader :project, :person
  
  def initialize(project, person, date_range)
    @project = project
    @person = person
    @timesheet = Timesheet.new(person, :project => project, :date_range => date_range)
  end
  
  def total
    @timesheet.total
  end
  
  def billing
    @timesheet.billing
  end
  
  def hours
    @timesheet.hours
  end
  
  def costs
    @timesheet.costs
  end
  
  def margin
    @timesheet.margin
  end
  
  def rate
    @project.rate_for(@person)
  end
  
end