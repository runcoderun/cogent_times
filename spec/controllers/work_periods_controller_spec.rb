require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/crud_controller_spec')

describe WorkPeriodsController do

  model(WorkPeriod) {{:person_id => Person.make.id, :project_id => Project.make.id, :hours => 1.0, :date => Date.today}}

  it_should_behave_like "any crud controller"
  
end
