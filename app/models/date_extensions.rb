module DateExtensions
  
  def start_of_week
    date = self
    while date.strftime('%A') != 'Monday'
      date = date - 1
    end
    return date  
  end
  
  def start_of_month
    date = self
    while date.day != 1
      date = date - 1
    end
    return date
  end
  
  def end_of_month
    date = self
    while (date + 1).day != 1
      date = date + 1
    end
    return date
  end
  
  def weekday?
    ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'].include?(self.strftime('%A'))
  end
  
  def weekend?
    ['Saturday', 'Sunday'].include?(self.strftime('%A'))
  end
  
end

class Date
  include DateExtensions
end