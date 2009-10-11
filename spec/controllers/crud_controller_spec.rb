require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

def model(clazz, attributes=nil, &attribute_block)
  define_method(:model_class) {return clazz}
  attr_accessor :valid_model_attributes
  attr_accessor :valid_parameters
  define_method(:initialize_attributes) do
    object_attributes = attributes || attribute_block.call 
    self.valid_model_attributes = as_attributes(object_attributes)
    self.valid_parameters = as_parameters(object_attributes)
  end
end

class Class
  
  def is_relationship?(name)
    return !!self.relationships[name]
  end
  
  def is_date_property?(name)
    self.properties.each do |property|
      if property.name == name 
        return property.type == Date
      end
    end
    return false
  end
  
  def related_class(relationship_name)
    return self.relationships[relationship_name].parent_model_name.constantize
  end
  
end

shared_examples_for 'any crud controller' do
  
  integrate_views

  before(:each) do
    initialize_attributes
  end
  
  def as_attributes(object_attributes)
    parameters = object_attributes.clone
    parameters.each do |key, value|
      if model_class.is_relationship?(key)
        parameters[:"#{key}_id"] = value.id
        parameters.delete(key)
      end
    end
    return parameters
  end
  
  def as_parameters(attributes)
    parameters = attributes.clone
    parameters.each do |key, value|
      if model_class.is_date_property?(key)
        parameters["#{key}(1i)"] = value.year.to_s
        parameters["#{key}(2i)"] = value.month.to_s
        parameters["#{key}(3i)"] = value.day.to_s
        parameters.delete(key)
      end
      if model_class.is_relationship?(key)
        parameters[key] = value.id
        # parameters["#{key}_id"] = value.id
        # parameters.delete(key)
      end
    end
    return parameters
  end
  
  def collection_sym
    model_class.to_s.pluralize.underscore.to_sym
  end
  
  def instance_sym
    model_class.to_s.underscore.to_sym
  end
  
  def clear_instances
    instances.all.each {|each| each.destroy}
  end
  
  def leave_one_instance
    clear_instances
    make_new_instance
  end
  
  def instances
    model_class.all
  end
  
  def instance
    model_class.first
  end
  
  def make_new_instance
    model_class.make
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
    response.should redirect_to("http://test.host/#{collection_sym.to_s}")
  end
  
  def check_instance_count(count)
    instances.should have(count).records
  end
  
  def check_instance_attributes
    instance.attributes.should == valid_model_attributes.merge(:id => instance.id)
  end
  
  it "should retrieve all instances for index" do
    leave_one_instance
    get :index
    should_render("index")
    collection_var.should have(1).record
  end
  
  it "should retrieve one instance for show" do
    leave_one_instance
    get :show, :id => instance.id
    should_render("show")
    instance_var.should == instance
  end

  it "should destroy one instance" do
    leave_one_instance
    delete :destroy, :id => instance.id
    check_index_displayed
    check_instance_count(0)
  end
  
  it "should display new instance" do
    cache_new_instance
    stub(model_class).new {cached_instance}
    put :new
    should_render("new")
    instance_var.should == cached_instance
  end
  
  it "should create new instance" do
    clear_instances
    post :create, instance_sym => valid_parameters
    check_index_displayed
    check_instance_count(1)
    check_instance_attributes
  end
  
  it "should update instance" do
    leave_one_instance
    put :update, :id => instance.id, instance_sym => valid_parameters
    check_index_displayed
    check_instance_count(1)
    check_instance_attributes
  end
  
end