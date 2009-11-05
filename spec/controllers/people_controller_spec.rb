require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/crud_controller_spec')

describe PeopleController do

  before(:each) do
    @controller.extend Authenticated
  end
  
  model Person, {:first_name => 'Steve', :surname => 'Hayes', :email=>nil, :fte=>1.0, :starting_sick_leave_hours=>0.0, :starting_annual_leave_hours=>0.0}

  it_should_behave_like "any crud controller"
  
end
