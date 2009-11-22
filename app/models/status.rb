class Status
   
   include DataMapper::Resource
   include DataMapper::ActiveRecordAdapter
   include DataMapper::ValidateAndSave
   
   property :id,          Serial
   property :description, String, :nullable => false
   
   has n, :story_statuses, :constraint => :protect
   has n, :daily_story_statuses, :constraint => :protect

   def self.first_by_description(description)
     return Status.first(:description => description) || Status.new(:description => description).validate_and_save
   end
   
end
