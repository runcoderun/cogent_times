class WorkPeriod
   
   include DataMapper::Resource
   
   property :id,          Serial
   property :date,        Date, :nullable => false
   property :hours,       Float, :nullable => false
   belongs_to :person
   belongs_to :project
   
   validates_present :person
   validates_present :project

   def billing
     return self.hours * project.hourly_rate_for(person)
   end
   
   def costs(oncosts)
     return self.hours * project.hourly_cost(person, oncosts)
   end
   
end
