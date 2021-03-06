class StoryStatus
   
  include DataMapper::Resource
  include DataMapper::ActiveRecordAdapter
  include DataMapper::ValidateAndSave
   
  property :id,          Serial
  property :atom_id,     String, :nullable => true
  property :person_name, String, :nullable => true
  property :datetime,    DateTime
   
  belongs_to :status
  belongs_to :story
  validates_present :story
  is :list, :scope => [:story_id]

  def status_text
    return status.description
  end
  
  def change
    StoryStatusChange.new(self, self.left_sibling)
  end
    
end
