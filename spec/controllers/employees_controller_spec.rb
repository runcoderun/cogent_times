require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EmployeesController do

  #Delete this example and add some real ones
  it "should use EmployeesController" do
    controller.should be_an_instance_of(EmployeesController)
  end

  it "should retrieve all instances for index" do
    # create an instance using machinist
    # invoke show
    Employee.make
    Employee.make
    get :index
    response.should render_template("index")
    assigns[:employees].should have(2).records
  end
end
