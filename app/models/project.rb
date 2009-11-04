class Project
  
  include DataMapper::Resource
  include DataMapper::Constraints
  include DataMapper::ActiveRecordAdapter
    
  property :id,    Serial
  property :name,  String, :nullable => false
  property :fixed_daily_rate, Float
  property :use_fixed_daily_rate, Boolean, :nullable => false, :default => false

  belongs_to :project_category
  validates_present :project_category
   
  has n, :work_periods, :constraint => :destroy
  has n, :stories, :constraint => :destroy
  
  delegate :use_in_reports, :to => :project_category
  
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
      return EmploymentCostsCalculator.new(person.salary, person.fte, oncosts).hourly_cost
    end
  end
   
  def category_name
    project_category.name
  end
  
end
