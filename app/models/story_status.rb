class StoryStatus
   
   include DataMapper::Resource
   include DataMapper::ActiveRecordAdapter
   
   property :id,          Serial
   property :atom_id,     String, :nullable => false
   property :status,      String, :nullable => false
   property :person_name, String, :nullable => true
   property :datetime,    DateTime
   
   belongs_to :story
   validates_present :story

end
