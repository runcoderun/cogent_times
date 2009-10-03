require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/crud_controller_spec')

describe EmployeesController do

  before(:each) do
    @model_class = Employee
    @valid_attributes = {:first_name => 'Steve', :surname => 'Hayes'}
  end

  it_should_behave_like "any crud controller"
  
end
