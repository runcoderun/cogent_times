class Project
  
  include DataMapper::Resource
  include DataMapper::Constraints
  include DataMapper::ActiveRecordAdapter
  include DataMapper::ValidateAndSave
    
  property :id,    Serial
  property :name,  String, :nullable => false
  property :fixed_daily_rate, Float, :default => 0.0
  property :use_fixed_daily_rate, Boolean, :nullable => false, :default => false
  property :starting_cost, Float, :nullable => false, :default => 0.0
  property :starting_hours, Float, :nullable => false, :default => 0.0
  property :pivotal_id, Integer, :nullable => true
  property :pivotal_activity_feed_id, String, :nullable => true
  
  belongs_to :project_category
  validates_present :project_category
   
  has n, :work_periods, :constraint => :protect
  has n, :stories, :constraint => :destroy
  has n, :expenses, :constraint => :destroy
  # has n, :story_statuses, :through => :stories
  
  delegate :use_in_reports, :to => :project_category

  def self.synch_all_with_pivotal
    self.all.each {|project| project.synchronise_with_pivotal}
  end
  
  def self.leave_without_pay
    Project.first(:name => 'Leave Without Pay')
  end
  
  def self.annual_leave
    Project.first(:name => 'Annual Leave')
  end
  
  def self.sick_leave
    Project.first(:name => 'Sick Leave')
  end
  
  def uses_pivotal?
    return !!self.pivotal_id
  end
  
  def work_periods_to(date)
    self.work_periods(:date.lte => date)
  end
  
  def expenses_to(date)
    self.expenses(:date.lte => date)
  end
  
  def people
    return (work_periods.collect &:person).uniq
  end
   
  def rate_for(person)
    assignment = Assignment.first(:person_id => person.id, :project_id => self.id)
    return assignment ? assignment.rate : 0.0
  end
   
  def hourly_rate_for(person)
    return rate_for(person) / SystemSetting.hours_per_day
  end
  
  def hourly_cost(person, oncosts)
    if use_fixed_daily_rate
      return fixed_daily_rate / SystemSetting.hours_per_day
    else
      return EmploymentCostsCalculator.new(person.id, person.full_name, person.salary, person.fte, oncosts).hourly_cost
    end
  end
   
  def category_name
    project_category.name
  end
  
  def labour_costs_to(date)
    self.work_periods_to(date).sum &:costs
  end
  
  def hours_to(date)
    self.work_periods_to(date).sum &:hours
  end
  
  def expenses_amount_to(date)
    self.expenses_to(date).sum &:amount
  end
  
  def total_hours_to(date)
    return self.starting_hours + self.hours_to(date)
  end
  
  def total_cost_to(date)
    return self.starting_cost + self.labour_costs_to(date) + self.expenses_amount_to(date)
  end
  
  def synchronise_with_pivotal
    ensure_has_all_pivotal_stories if uses_pivotal?
    return self
  end
  
  def update_from_pivotal_activity
    return unless uses_pivotal?
    CogentPivotalTrackerActivity.new(self.pivotal_id, self.pivotal_activity_feed_id).each do |action|
      status = StoryStatus.first(:atom_id => action.atom_id)
      if !status && action.new_state # ignore comments etc
        story = Story.first(:pivotal_id => action.story_id)
        status = StoryStatus.new(:atom_id => action.atom_id, :story => story, :person_name => action.name, :status => action.new_state, :datetime => action.timestamp)
        status.validate_and_save
      end
    end
  end
  
  def pivotal_tracker
    @pivotal_tracker ||= CogentPivotalTracker.new(self.pivotal_id)
  end

  def status_changes
    (self.stories.collect &:last_story_status_change).compact
  end
  
  def latest_statuses_in(date_range)
    (self.stories.collect {|story| story.latest_story_status_in(date_range)}).compact
  end
  
  private

  def pivotal_tracker_stories
    return pivotal_tracker.stories
  end
  
  def ensure_has_all_pivotal_stories
    pivotal_tracker_stories.each do |story|
      ensure_has_pivotal_story(story.id, story.name, story.current_state.capitalize)
    end
  end

  def ensure_has_pivotal_story(pivotal_id, name, current_state)
    story = self.stories(:pivotal_id => pivotal_id).first || ::Story.new(:project_id => self.id, :pivotal_id => pivotal_id)
    if story.name != name
      story.name = name
      story.validate_and_save
    end
    if story.current_state != current_state
      status = Status.first_by_description(current_state)
      story_status = StoryStatus.new(:story => story, :person_name =>'' , :status => status, :datetime => Time.new)
      story_status.validate_and_save
    end
  end
  
end
