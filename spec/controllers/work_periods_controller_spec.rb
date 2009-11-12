require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/crud_controller_spec')

describe WorkPeriodsController do

  before(:each) do
    @controller.extend Authenticated
  end
  
  model(WorkPeriod) {{:person => Person.make, :project => Project.make, :hours => 1.0, :date => Date.today, :description => nil}}

  it_should_behave_like "any crud controller"
  
  it "should fail" do
    get :does_not_exist
  end
  
end
