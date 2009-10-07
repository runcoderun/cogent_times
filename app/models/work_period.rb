class WorkPeriod
   include DataMapper::Resource
 
   property :id,          Serial
   property :date,        Date
   property :hours,       Float
   belongs_to :person
   belongs_to :project
   
end
