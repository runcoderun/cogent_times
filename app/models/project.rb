class Project
  
  include DataMapper::Resource
  include DataMapper::Constraints
  include DataMapper::ActiveRecordAdapter
    
  property :id,    Serial
  property :name,  String, :nullable => false
  property :fixed_daily_rate, Float, :default => 0.0
  property :use_fixed_daily_rate, Boolean, :nullable => false, :default => false
  property :starting_cost, Float, :nullable => false, :default => 0.0
  property :starting_hours, Float, :nullable => false, :default => 0.0
  
  belongs_to :project_category
  validates_present :project_category
   
  has n, :work_periods, :constraint => :protect
  has n, :stories, :constraint => :destroy
  has n, :expenses, :constraint => :destroy
  
  delegate :use_in_reports, :to => :project_category

  def self.leave_without_pay
    Project.first(:name => 'Leave Without Pay')
  end
  
  def self.annual_leave
    Project.first(:name => 'Annual Leave')
  end
  
  def self.sick_leave
    Project.first(:name => 'Sick Leave')
  end
  
  def work_periods_to(date)
    self.work_periods(:date.lte => date)
  end
  
  def expenses_to(date)
    self.expenses(:date.lte => date)
  end
  
  def people
    return (work_periods.collect &:person).uniq
  end
   
  def rate_for(person)
    assignment = Assignment.first(:person_id => person.id, :project_id => self.id)
    return assignment ? assignment.rate : 0.0
  end
   
  def hourly_rate_for(person)
    return rate_for(person) / SystemSetting.hours_per_day
  end
  
  def hourly_cost(person, oncosts)
    if use_fixed_daily_rate
      return fixed_daily_rate / SystemSetting.hours_per_day
    else
      return EmploymentCostsCalculator.new(person.id, person.full_name, person.salary, person.fte, oncosts).hourly_cost
    end
  end
   
  def category_name
    project_category.name
  end
  
  # def labour_costs
  #   return labour_costs_to(Date.today)
  # end
  
  def labour_costs_to(date)
    self.work_periods_to(date).sum &:costs
  end
  
  # def hours
  #   return hours_to(Date.today)
  # end
  
  def hours_to(date)
    self.work_periods_to(date).sum &:hours
  end
  
  # def expenses_amount
  #   self.expenses.sum &:amount
  # end
  
  def expenses_amount_to(date)
    self.expenses_to(date).sum &:amount
  end
  
  # def cost_to_date
  #   return cost_to(Date.today)
  # end
  
  def cost_to(date)
    return self.starting_cost + self.labour_costs_to(date) + self.expenses_amount_to(date)
  end
  
end
