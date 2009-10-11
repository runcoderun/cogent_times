class WorkPeriod
   
   include DataMapper::Resource
   # include DataMapper::Validates
   
   property :id,          Serial
   property :date,        Date
   property :hours,       Float
   belongs_to :person
   belongs_to :project
   
   validates_present :person
   validates_present :project
   
end
