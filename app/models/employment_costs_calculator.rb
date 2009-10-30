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
  
  def total_cost
    self.weighted_wages_costs + self.oncosts
  end
  
  def daily_cost
    self.total_cost / self.class.working_days_per_year
  end
  
end