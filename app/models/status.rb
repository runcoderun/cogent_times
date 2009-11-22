class Status
   
   include DataMapper::Resource
   include DataMapper::ActiveRecordAdapter
   include DataMapper::ValidateAndSave
   
   property :id,          Serial
   property :description, String, :nullable => false
   
   has n, :story_statuses, :constraint => :protect
   has n, :daily_story_statuses, :constraint => :protect

end
