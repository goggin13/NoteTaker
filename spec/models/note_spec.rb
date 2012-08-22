require 'spec_helper'

describe Note do

  def valid_attributes
    {
      :title => "NoteTitle", 
      :course_id => 1,
      :body => "Note Body",
      :day => Time.now
    }
  end
  
  it "should create in instance with valid attributes" do
    attrs = valid_attributes
    n = Note.create! attrs
    n.title.should == attrs[:title]
    n.course_id.should == attrs[:course_id]
    n.body.should == attrs[:body]
  end
  
  it "should require a title" do
    (Note.new (valid_attributes.merge :title => nil)).should_not be_valid
  end
  
  it "should require a course_id" do
    (Note.new (valid_attributes.merge :course_id => nil)).should_not be_valid
  end 
  
  it "should require a day" do
    (Note.new (valid_attributes.merge :day => nil)).should_not be_valid
  end   

end
