require 'date_extensions'

class TimesheetCheck
  
  attr_reader :start_date, :end_date
  
  def initialize(base_date)
    @start_date = base_date.start_of_month
    @end_date = base_date.end_of_month
  end
  
  def weeks
    weeks = []
    week_start = self.start_date
    while week_start < self.end_date
      weeks << TimesheetCheckWeek.new(week_start)
      week_start = week_start + 7
    end
    return weeks
  end
  
end

class TimesheetCheckWeek
  
  attr_reader :start_date, :end_date
  
  def initialize(base_date)
    @start_date = base_date.start_of_week
    @end_date = base_date.end_of_week
    @hours = {}
  end
  
  def hours_for(person)
    @hours[person] ||= Timesheet.new(person, :date_range => @start_date..@end_date).total
  end
  
  def incomplete?(person)
    return hours_for(person) != 40.0
  end
  
end