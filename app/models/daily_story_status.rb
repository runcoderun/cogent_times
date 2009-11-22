class DailyStoryStatus
   
   include DataMapper::Resource
   include DataMapper::ActiveRecordAdapter
   include DataMapper::ValidateAndSave
   
   property :id,    Serial
   property :date,  Date
   
   belongs_to :status
   belongs_to :story
   validates_present :status
   validates_present :story

end
