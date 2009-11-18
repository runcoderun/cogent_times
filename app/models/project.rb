class Project
  
  include DataMapper::Resource
  include DataMapper::Constraints
  include DataMapper::ActiveRecordAdapter
    
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
  
  delegate :use_in_reports, :to => :project_category

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
    return unless uses_pivotal?
    pivotal_tracker.stories.each do |story|
      ensure_pivotal_story(story.id, story.name)
    end
    return self
  end
  
  def update_from_pivotal_activity
    return unless uses_pivotal?
    CogentPivotalTrackerActivity.new(self.pivotal_id, self.pivotal_activity_feed_id).each do |action|
      puts action.atom_id
      puts action.story_id
      puts action.name
      puts action.action
      puts action.new_state
      status = StoryStatus.first(:atom_id => action.atom_id)
      if !status && action.new_state # ignore comments etc
        story = Story.first(:pivotal_id => action.story_id)
        status = StoryStatus.new(:atom_id => action.atom_id, :story => story, :person_name => action.name, :status => action.new_state, :datetime => action.timestamp)
        status.save
        require 'pp'
        pp status.errors
        
      end
    end
  end
  
  def pivotal_tracker
    @pivotal_tracker ||= CogentPivotalTracker.new(self.pivotal_id)
  end
  
  private

  def ensure_pivotal_story(pivotal_id, name)
    story = self.stories(:pivotal_id => pivotal_id).first || ::Story.new(:project_id => self.id, :pivotal_id => pivotal_id)
    if story.name != name
      story.name = name
      story.save
    end
  end
  
end
