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
    instances.destroy!
  end
  
  def instances
    @model_class.all
  end
  
  def make_new_instance
    @model_class.make
  end

  def cache_new_instance
    @instance = make_new_instance
  end
  
  def cached_instance
    @instance || cache_new_instance
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

  def check_index_displayed
    response.should redirect_to("http://test.host/employees")
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
    get :show, :id => cached_instance.id
    should_render("show")
    instance_var.should == cached_instance
  end

  it "should destroy one instance" do
    clear_instances
    get :destroy, :id => cached_instance.id
    check_index_displayed
    instances.count.should == 0
  end
  
  it "should display new instance" do
    cache_new_instance
    stub(@model_class).new {cached_instance}
    put :new
    should_render("new")
    instance_var.should == cached_instance
  end
  
  it "should create new instance" do
    clear_instances
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
