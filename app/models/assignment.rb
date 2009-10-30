class Assignment
   
   include DataMapper::Resource
   
   property :id,          Serial
   property :rate,       Float, :nullable => false
   belongs_to :person
   belongs_to :project
   
   validates_present :person
   validates_present :project
   
end
