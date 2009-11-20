require 'simple-rss'
require 'open-uri'

class CogentPivotalTrackerActivity
  
  def initialize(project_id, atom_feed_id)
    @project_id, @atom_feed_id = project_id, atom_feed_id
    puts "called with #{project_id}, #{atom_feed_id}"
  end
  
  def each
    rss.entries.each do |entry|
      activity = RssActivity.new(entry)
      if activity.name && activity.action
        yield PivotalTrackerAction.new(activity.rss_id, activity.story_id, activity.name, activity.action, activity.updated)
      else
        Error.record("Could not parse name and action out of #{name_and_action}")
      end
    end
  end
  
  private
  
  def rss
    url = "http://www.pivotaltracker.com/projects/#{@project_id}/activities/#{@atom_feed_id}"
    return SimpleRSS.parse open(url)
  end
  
end

class RssActivity

  attr_reader :entry
  
  def initialize(entry)
    @entry = entry
  end
  
  def updated
    return entry[:updated]
  end
  
  def rss_id
    return entry[:id]
  end
  
  def story_id
    /\d*$/.match(entry.link)[0]
  end
  
  def name
    @name ||= name_and_action_match ? name_and_action_match.pre_match : nil
  end
  
  def action
    @action ||= name_and_action_match ? name_and_action_match[1] : nil
  end
  
  private
  
  def name_and_action_match
    @activity_text ||= /<p>(.*)<\/p>/.match(entry.content)[1]
    @name_and_action ||= /^(.*?)&quot;/.match(activity_text)[1]
    @name_and_action_match ||= /(delivered|rejected|added comment|added|finished|started):*$/.match(@name_and_action.strip)
  end
    
end

class PivotalTrackerAction
  
  attr_reader :atom_id, :story_id, :name, :action, :timestamp
  
  def initialize(atom_id, story_id, name, action, timestamp)
    @atom_id, @story_id, @name, @action, @timestamp = atom_id, story_id, name, action, timestamp
  end
  
  def new_state
    return new_states[action]
  end
  
  private
  
  def new_states
    { 'added' => 'Not Yet Started', 
      'started' => 'Started',
      'finished' => 'Finished', 
      'delivered' => 'Delivered', 
      'accepted' => 'Accepted',
      'rejected' => 'Rejected',
      'added comment' => nil }
  end
  
end
