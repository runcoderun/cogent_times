class Person
  
  include DataMapper::Resource
  include DataMapper::Constraints
  include DataMapper::ActiveRecordAdapter
  
  property :id,          Serial
  property :surname,     String, :nullable => false
  property :first_name,  String, :nullable => false
  property :email,       String, :nullable => true
  property :fte,         Float,  :nullable => false, :default => 1.0  
  property :starting_annual_leave_hours, Float, :nullable => false, :default => 0.0
  property :starting_sick_leave_hours,   Float, :nullable => false, :default => 0.0
  
  has n, :work_periods, :constraint => :destroy
  has n, :salaries, :constraint => :destroy
      
  def full_name
    return "#{first_name} #{surname}"
  end
  
  def salary
    salaries.empty? ? 0.0 : salaries.first.amount
  end
   
  def annual_leave_taken
    Timesheet.new(self, :project => Project.annual_leave).hours
  end
      
  def sick_leave_taken
    Timesheet.new(self, :project => Project.sick_leave).hours
  end
      
end
