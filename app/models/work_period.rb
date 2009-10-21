class WorkPeriod
   
   include DataMapper::Resource
   
   property :id,          Serial
   property :date,        Date, :nullable => false
   property :hours,       Float, :nullable => false
   belongs_to :person
   belongs_to :project
   
   validates_present :person
   validates_present :project
   
end
