class Project
  
   include DataMapper::Resource
   include DataMapper::Constraints
   include DataMapper::ActiveRecordAdapter
    
   property :id,    Serial
   property :name,  String, :nullable => false
   
   has n, :work_periods, :constraint => :destroy
   has n, :stories, :constraint => :destroy
   
   def people
     return (work_periods.collect &:person).uniq
   end
   
end
