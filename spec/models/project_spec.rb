require File.dirname(__FILE__) + '/../spec_helper'

describe Project do

  describe "synchronising with pivotal" do

    # def synchronise_with_pivotal
    #   return unless uses_pivotal?
    #   pivotal_tracker.stories.each do |story|
    #     ensure_pivotal_story(story.id, story.name, story.current_state.capitalize)
    #   end
    #   return self
    # end

    before(:each) do
      @project = Project.make
    end
    
    def make_project_use_pivotal
      @project.pivotal_id = 99
    end
    
    it "should not invoke pivotal tracker if no pivotal id" do
      dont_call(@project).ensure_has_all_pivotal_stories
      @project.synchronise_with_pivotal
    end
    
    it "should be able to synchronise with pivotal" do
      Story.all.destroy!
      make_project_use_pivotal
      pivotal_story = PivotalTracker::Story.new
      stub(pivotal_story).id {1}
      stub(pivotal_story).name {'A test story'}
      stub(pivotal_story).current_state {'accepted'}
      stub(@project).pivotal_tracker_stories {[pivotal_story]}
      @project.synchronise_with_pivotal
      Story.all.should have(1).story
    end
    
  end
  
end
