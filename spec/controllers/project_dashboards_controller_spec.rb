require File.dirname(__FILE__) + '/../spec_helper'

describe ProjectDashboardsController do
  
  before(:each) do
    @controller.extend Authenticated
  end
  
  integrate_views
  
  it "should work ok when there's not really anything to display" do
    get :show, :project_id => Project.make.id
  end
  
end
