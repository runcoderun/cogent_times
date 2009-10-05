require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/crud_controller_spec')

describe ProjectsController do

  model Project, {:name => 'A Test Project'}

  it_should_behave_like "any crud controller"
  
end
