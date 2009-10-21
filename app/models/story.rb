class Story
   
   include DataMapper::Resource
   
   property :id,           Serial
   property :name,         String, :nullable => false
   property :created_at, DateTime
   property :updated_at, DateTime
   belongs_to :project
   
   validates_present :project

   before :valid?, :set_name
   
   def set_name(context = :default)
     self.name ||= 'name not provided'
   end
   
end
