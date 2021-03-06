class EmploymentCostsCalculator
  
  attr_reader :salary, :fte_weight
  
  #############
  # constants
  #############
  
  def self.weekdays_per_year
    250
  end
  
  def self.working_days_per_year
    self.weekdays_per_year - SystemSetting.public_holidays_per_year - SystemSetting.annual_leave_days_per_year - SystemSetting.sick_leave_days_per_year
  end
  
  def superannuation_rate
    0.09
  end
  
  def payroll_tax_rate
    0.055
  end
  
  ###################
  # end of constants
  ###################
  
  def initialize(person_id, person_name, salary, fte_weight, oncosts)
    @person_id = person_id
    @person_name = person_name
    @salary = salary
    @fte_weight = fte_weight
    @oncosts = oncosts
  end
  
  def person_id
    @person_id
  end
  
  def person_name
    @person_name
  end
  
  def salary
    @salary
  end
  
  def fte
    @fte_weight
  end
  
  def superannuation
    self.salary * self.superannuation_rate
  end
  
  def payroll_tax
    (self.salary + self.superannuation) * self.payroll_tax_rate
  end
  
  def total_wages_costs
    self.salary + self.superannuation + self.payroll_tax
  end
  
  def weighted_wages_costs
    self.total_wages_costs * self.fte_weight
  end
  
  def oncosts
    return @oncosts.cost(self.fte_weight)
  end
  
  def weighted_total_cost
    self.weighted_wages_costs + self.oncosts
  end
  
  def daily_cost
    self.weighted_total_cost / weighted_working_days
  end

  def hourly_cost
    return daily_cost / SystemSetting.hours_per_day
  end
  
  def average_monthly_cost    
    self.weighted_total_cost / SystemSetting.months_per_year
  end

  def weighted_working_days
    self.class.working_days_per_year * self.fte_weight
  end
  
end