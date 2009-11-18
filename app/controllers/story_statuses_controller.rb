class StoryStatusesController < SecureController
  
  def index
    require 'pp'
    pp params
    @story_statuses = StoryStatus.all(:story_id => params[:story_id])
  end
  
end
