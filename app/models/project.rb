class Project
  
   include DataMapper::Resource
   include DataMapper::Constraints
   include DataMapper::ActiveRecordAdapter
    
   property :id,    Serial
   property :name,  String, :nullable => false
   property :fixed_daily_rate, Float
   property :use_fixed_daily_rate, Boolean, :nullable => false, :default => false
   
   has n, :work_periods, :constraint => :destroy
   has n, :stories, :constraint => :destroy
   
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
   
end
