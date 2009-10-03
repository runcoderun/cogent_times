class Employee
   include DataMapper::Resource
 
   property :id,          Serial
   property :surname,     String, :nullable => false
   property :first_name,  String, :nullable => false
   
   # def to_param
   #  return self.id.to_s
   # end
   
end
