class Salary
   
   include DataMapper::Resource
   
   property :id,          Serial
   property :start_date,  Date, :nullable => false
   property :amount,      Float, :nullable => false
   belongs_to :person

   validates_present :person
   
end
