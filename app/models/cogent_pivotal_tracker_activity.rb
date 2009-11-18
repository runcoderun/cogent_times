require 'simple-rss'
require 'open-uri'

class CogentPivotalTrackerActivity
  
  def initialize(project_id, atom_feed_id)
    @project_id, @atom_feed_id = project_id, atom_feed_id
    puts "called with #{project_id}, #{atom_feed_id}"
  end
  
  def each
    require 'pp'
    rss.entries.each do |entry|
      pp entry
      story_id = /\d*$/.match(entry.link)[0]
      activity_text = /<p>(.*)<\/p>/.match(entry.content)[1]
      name_and_action = /^(.*?)&quot;/.match(activity_text)[1]
      name_and_action_match = /(delivered|rejected|added comment|added|finished|started):*$/.match(name_and_action.strip)
      if name_and_action_match
        name = name_and_action_match.pre_match
        action = name_and_action_match[1]
        yield PivotalTrackerAction.new(entry[:id], story_id, name, action, entry[:updated])
      else
        error = Error.new(:text => "Could not parse name and action out of #{name_and_action}", :datetime => Time.now)
        error.save
        pp error.errors
      end
    end
  end
  
  private
  
  def rss
    url = "http://www.pivotaltracker.com/projects/#{@project_id}/activities/#{@atom_feed_id}"
    return SimpleRSS.parse open(url)
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

# CogentPivotalTrackerActivity.new(35924, '7a537df7596d81351ea46056346ffb29').each do |action|
#   puts action.story_id
#   puts action.name
#   puts action.action
#   puts action.new_state
# end
