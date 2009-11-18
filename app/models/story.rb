class Story
   
   include DataMapper::Resource
   include DataMapper::ActiveRecordAdapter
   
   property :id,           Serial
   property :name,         String, :nullable => false
   property :pivotal_id,   Integer, :nullable => true
   property :created_at,   DateTime
   property :updated_at,   DateTime
   property :completed,    Boolean
   property :completed_at, DateTime
   
   belongs_to :project
   has n, :story_statuses, :constraint => :destroy
   
   validates_present :project

   before :valid?, :set_name
   before :save, :align_completion_timestamp
   
   def set_name(context = :default)
     self.name ||= 'name not provided'
   end
   
   def align_completion_timestamp
     if self.completed
       self.completed_at = Time.now unless self.completed_at
     else
       self.completed_at = nil
     end
   end
   
end
