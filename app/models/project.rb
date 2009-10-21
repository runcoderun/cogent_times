class Project
  
   include DataMapper::Resource
   include DataMapper::Constraints
    
   property :id,    Serial
   property :name,  String, :nullable => false
   
   has n, :work_periods, :constraint => :destroy
   has n, :stories, :constraint => :destroy
   
end
