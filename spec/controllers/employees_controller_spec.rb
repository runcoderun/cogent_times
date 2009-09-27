require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EmployeesController do

  integrate_views
  
  #Delete this example and add some real ones
  it "should use EmployeesController" do
    controller.should be_an_instance_of(EmployeesController)
  end

  it "should retrieve all instances for index" do
    Employee.all.destroy!
    Employee.make
    Employee.make
    get :index
    response.should render_template("index")
    assigns[:employees].should have(2).records
  end
  
  it "should retrieve one instance for show" do
    Employee.all.destroy!
    employee = Employee.make
    get :show, :id => employee.id
    response.should render_template("show")
    assigns[:employee].should == employee
  end
  
  
end
