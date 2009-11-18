class PivotalTracker::Iteration
  include HappyMapper
  element :id, Integer
  element :number, Integer
  element :start, DateTime
  has_many :stories, PivotalTracker::Story
end
