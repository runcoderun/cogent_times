class Employee
   include DataMapper::Resource
 
   property :id,          Serial
   property :surname,     String, :nullable => false
   property :first_name,  String, :nullable => false
   
end
