class WorkPeriod
   
   include DataMapper::Resource
   
   property :id,          Serial
   property :date,        Date, :nullable => false
   property :hours,       Float, :nullable => false
   belongs_to :person
   belongs_to :project
   
   validates_present :person
   validates_present :project

   def self.cleanup
     self.all(:hours => 0.0).destroy!
   end
   
   def billing
     return self.hours * project.hourly_rate_for(person)
   end
   
   def costs
     return self.hours * project.hourly_cost(person, OnCostsCalculator.new(Oncost.amount_on(self.date)))
   end
   
end
