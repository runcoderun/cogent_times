require File.dirname(__FILE__) + '/../spec_helper'

describe StoryStatus do
  
  it "should answer some status text" do
    story = Story.make
    story_status = StoryStatus.new(:story => story, :status_text => 'Accepted').validate_and_save
    story_status.status_text.should == 'Accepted'
  end
  
end
