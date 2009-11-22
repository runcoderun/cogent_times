require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/crud_controller_spec')

describe ProjectsController do

  before(:each) do
    @controller.extend Authenticated
  end
  
  model(Project) {{ :name => 'A Test Project', :fixed_daily_rate=>0.0, :use_fixed_daily_rate=>false, 
                    :starting_cost=>0.0, :starting_hours=>0.0, :pivotal_id=>nil, :pivotal_activity_feed_id=>nil, 
                    :project_category_id => ProjectCategory.make.id}}

  it_should_behave_like "any crud controller"
  
end
