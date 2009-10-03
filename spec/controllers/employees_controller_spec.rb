require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EmployeesController do

  integrate_views
  
  before(:each) do
    @model_class = Employee
  end
  
  def collection_sym
    @model_class.to_s.pluralize.underscore.to_sym
  end
  
  def instance_sym
    @model_class.to_s.underscore.to_sym
  end
  
  def clear_instances
    @model_class.all.destroy!
  end
  
  def make_new_instance
    @model_class.make
  end
  
  def should_render(template)
    response.should render_template(template)
  end

  def collection_var
    assigns[collection_sym]
  end
  
  def instance_var
    assigns[instance_sym]
  end
  
  it "should retrieve all instances for index" do
    clear_instances
    make_new_instance
    get :index
    should_render("index")
    collection_var.should have(1).record
  end
  
  it "should retrieve one instance for show" do
    clear_instances
    employee = make_new_instance
    get :show, :id => employee.id
    should_render("show")
    instance_var.should == employee
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
  
  it "should create new instance" do
    Employee.all.destroy!
    valid_attributes = {:first_name => 'Steve', :surname => 'Hayes'}
    put :create, :employee => valid_attributes
    response.should redirect_to("http://test.host/employees")
    Employee.all.should have(1).record
    Employee.first.attributes.should == valid_attributes.merge(:id => Employee.first.id)
  end
  
  it "should update instance" do
    Employee.all.destroy!
    Employee.make
    valid_attributes = {:first_name => 'Steve', :surname => 'Hayes'}
    put :update, :id => Employee.first.id, :employee => valid_attributes
    response.should redirect_to("http://test.host/employees")
    Employee.all.should have(1).record
    Employee.first.attributes.should == valid_attributes.merge(:id => Employee.first.id)
  end
  
  # def update
  
end
