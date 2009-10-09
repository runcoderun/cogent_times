require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/crud_controller_spec')

describe PeopleController do

  model Person, {:first_name => 'Steve', :surname => 'Hayes'}

  it_should_behave_like "any crud controller"
  
end