class Costs
  
  def initialize(people, oncosts_calculator)
    @people = people
    @oncosts_calculator = oncosts_calculator
  end
  
  def people_costs
    @people_costs ||= @people.collect do |person|
      EmploymentCostsCalculator.new(person.id, person.full_name, person.salary, person.fte, @oncosts_calculator)
    end
  end
  
  def fte
    self.people_costs.sum &:fte
  end
  
  def weighted_wages_costs
    self.people_costs.sum &:weighted_wages_costs
  end
  
  def oncosts
    self.people_costs.sum &:oncosts
  end
  
  def daily_cost
    self.people_costs.sum &:daily_cost
  end
  
  def average_monthly_cost
    self.people_costs.sum &:average_monthly_cost
  end
  
end
