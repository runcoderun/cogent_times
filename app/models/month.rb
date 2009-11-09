require 'date_extensions'
require 'range_extensions'

class Month
  
  def initialize(some_date)
    @date_range = some_date.start_of_month..some_date.end_of_month
  end
  
  def working_day_count
    @working_day_count ||= working_days.size
  end
  
  private
  
  def weekdays
    @week_days ||= @date_range.select {|date| date.weekday?}
  end
  
  def days
    @days ||= @date_range.select {|date| true}
  end
  
  def public_holidays
    @public_holidays ||= PublicHoliday.all(:date.gte => @date_range.first, :date.lte => @date_range.last).collect &:date
  end

  def weekday_public_holidays
    @weekday_public_holidays ||= public_holidays.select &:weekday?
  end
  
  def working_days
    @working_days ||= weekdays - weekday_public_holidays
  end
  
end
