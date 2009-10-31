class EmploymentCostsCalculator
  
  attr_reader :salary, :fte_weight
  
  def self.superannuation_rate
    0.09
  end
  
  def self.payroll_tax_rate
    0.055
  end
  
  def self.working_days_per_year
    250
  end
  
  def self.months_per_year
    12
  end
  
  def initialize(salary, fte_weight, oncosts)
    @salary = salary
    @fte_weight = fte_weight
    @oncosts = oncosts
  end
  
  def superannuation
    self.salary * self.class.superannuation_rate
  end
  
  def payroll_tax
    (self.salary + self.superannuation) * self.class.payroll_tax_rate
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
  
  def average_daily_cost    
    self.weighted_total_cost / self.class.working_days_per_year
  end

  def average_monthly_cost    
    self.weighted_total_cost / self.class.months_per_year
  end

  def weighted_working_days
    self.class.working_days_per_year * self.fte_weight
  end
  
end