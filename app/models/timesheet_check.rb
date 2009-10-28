require 'date_extensions'

class TimesheetCheck
  
  attr_reader :start_date, :end_date
  
  def initialize(base_date)
    @start_date = base_date.start_of_month
    @end_date = base_date.end_of_month
  end
  
  def weeks
    @weeks ||= constructed_weeks
  end

  def incomplete?(person)
    return weeks.any? {|each| each.incomplete?(person)}
  end
  
  private
  
  def constructed_weeks
    weeks = []
    week_start = self.start_date
    while week_start < self.end_date
      weeks << TimesheetCheckWeek.new(week_start, [week_start.end_of_week, self.end_date].min)
      week_start = week_start.end_of_week + 1
    end
    return weeks
  end
  
end

class TimesheetCheckWeek
  
  def initialize(start_date, end_date)
    @date_range = start_date..end_date
    @hours = {}
  end
  
  def hours_for(person)
    @hours[person] ||= Timesheet.new(person, :date_range => self.date_range).total
  end
  
  def incomplete?(person)
    return hours_for(person) != expected_hours
  end
  
  def end_date
    self.date_range.end
  end
  
  def start_date
    self.date_range.begin
  end
  
  def description
    return "#{days_included} days ending #{self.end_date.strftime('%a <br>%d %b %y')}"
  end
  
  def expected_hours
    self.work_days_included * 8
  end
  
  def work_days_included
    self.date_range.select {|date| date.weekday?}.size
  end
  
  def days_included
    self.date_range.to_a.size
  end
  
  def date_range
    @date_range
  end
  
end