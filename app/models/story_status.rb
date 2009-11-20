class StoryStatus
   
   include DataMapper::Resource
   include DataMapper::ActiveRecordAdapter
   include DataMapper::ValidateAndSave
   
   property :id,          Serial
   property :atom_id,     String, :nullable => true
   property :status,      String, :nullable => false
   property :person_name, String, :nullable => true
   property :datetime,    DateTime
   
   belongs_to :story
   validates_present :story
   is :list, :scope => [:story_id]

end
