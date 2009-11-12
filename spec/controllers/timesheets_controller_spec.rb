require File.dirname(__FILE__) + '/../spec_helper'

describe TimesheetsController do
  
  integrate_views
  
  before(:each) do
    @controller.extend Authenticated
  end

  it "should create a work period" do
    project = Project.first
    person = Person.first
    date = Date.today
    put :update, :id => person.id, :project_id => project.id, :date => date.to_json, :hours => '9.9'
    work_period_key = {:project_id => project.id, :person_id => person.id, :date => date}
    WorkPeriod.all(work_period_key).should have(1).work_period
    WorkPeriod.first(work_period_key).hours.should == 9.9
  end
  
end
