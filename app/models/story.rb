class Story
   
   include DataMapper::Resource
   include DataMapper::ActiveRecordAdapter
   include DataMapper::ValidateAndSave
   
   property :id,           Serial
   property :name,         String, :size => 255, :nullable => false
   property :pivotal_id,   Integer, :nullable => true
   
   belongs_to :project
   has n, :story_statuses, :order => [ :datetime.desc ], :constraint => :destroy
   has n, :daily_story_statuses, :order => [ :date.desc ], :constraint => :destroy
   
   validates_present :project

   before :valid?, :set_name
   
   def set_name(context = :default)
     self.name ||= 'name not provided'
   end
   
   def current_state
     current_story_status ? current_story_status.status : 'Unknown'
   end
   
   def last_story_status_change
     current_story_status ? current_story_status.change : nil
   end
   
   def latest_story_status_in(date_range)
     StoryStatus.first(:datetime => date_range, :story_id => self.id, :order => [ :datetime.desc ])
   end
   
   def story_status_on(date)
     StoryStatus.first(:datetime.lte => date, :story_id => self.id, :order => [ :datetime.desc ])
   end
   
   private
   
   def current_story_status
     self.story_statuses.first
   end
   
end
