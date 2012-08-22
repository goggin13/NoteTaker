require 'spec_helper'

describe Course do
  
  def valid_attributes
    {:name => "CourseName"}
  end
  
  it "should create in instance with valid attributes" do
    attrs = valid_attributes
    c = Course.create! attrs
    c.name.should == attrs[:name]
  end
  
  it "should require a name" do
    (Course.new (valid_attributes.merge :name => nil)).should_not be_valid
  end
  
end
