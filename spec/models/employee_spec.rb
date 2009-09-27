require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Employee do
  before(:each) do
    @valid_attributes = {
      :first_name => 'Bob',
      :surname => 'Hawke'
    }
  end

  it "should create a new instance given valid attributes" do
    Employee.new(@valid_attributes)
  end
end
