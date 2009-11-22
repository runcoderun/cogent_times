class StoryStatusChange
  
  def initialize(later_status, earlier_status)
    @later_status, @earlier_status = later_status, earlier_status
  end
  
  def datetime
    @later_status.datetime
  end
  
  def story_id
    @later_status.story_id
  end
  
  def from_status
    @earlier_status ? @earlier_status.status : 'Unknown'
  end
  
  def to_status
    @later_status.status
  end
  
end