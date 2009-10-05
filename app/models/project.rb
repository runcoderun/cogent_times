class Project
   include DataMapper::Resource
 
   property :id,    Serial
   property :name,  String, :nullable => false
   
   has n, :work_periods
   
end
