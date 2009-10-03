require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EmployeesController do

  integrate_views
  
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

  it "should destroy one instance" do
    Employee.all.destroy!
    employee = Employee.make
    get :destroy, :id => employee.id
    response.should redirect_to("http://test.host/employees")
    Employee.all.count.should == 0
  end
  
  it "should display new instance" do
    employee = Employee.make
    stub(Employee).new {employee}
    put :new
    response.should render_template("new")
    assigns[:employee].should == employee
  end
  
  # def new
  # def create
  # def update
  
end
