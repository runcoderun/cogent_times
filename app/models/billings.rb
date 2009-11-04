class Billings
  
  def initialize(projects, annual_oncosts, start_date, end_date)
    @projects = projects
    @oncosts = OnCostsCalculator.new(annual_oncosts)
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
      timesheets = project.people.sort_by{|person| person.full_name}.collect {|person| BillingTimesheet.new(project, person, @start_date..@end_date, @oncosts)}.reject {|timesheet| timesheet.total == 0}
      @timesheets_by_project[project] = timesheets unless timesheets.empty?
    end
  end
  
  def timesheets
    @timesheets_by_project.values.flatten
  end
  
end

class BillingTimesheet
  
  def initialize(project, person, date_range, oncosts)
    @project = project
    @person = person
    @timesheet = Timesheet.new(person, :project => project, :date_range => date_range)
    @oncosts = oncosts
  end
  
  def person
    @person
  end
  
  def total
    @timesheet.total
  end
  
  def billing
    @timesheet.billing
  end
  
  def costs
    @timesheet.costs(@oncosts)
  end
  
  def margin
    @timesheet.margin(@oncosts)
  end
  
  def rate
    @project.rate_for(@person)
  end
  
end