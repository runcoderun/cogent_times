class Person
  
  include DataMapper::Resource
  include DataMapper::Constraints
  
  property :id,          Serial
  property :surname,     String, :nullable => false
  property :first_name,  String, :nullable => false
   
  has n, :work_periods, :constraint => :destroy
      
  def full_name
    return "#{first_name} #{surname}"
  end
    
end
