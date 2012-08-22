require 'spec_helper'

describe "notes/index" do
  before(:each) do
    @course = Course.create! :name => "new course"
    assign(:notes, [
      stub_model(Note,
        :title => "Title",
        :body => "MyText",
        :course_id => @course.id,
        :day => Time.now
      ),
      stub_model(Note,
        :title => "Title",
        :body => "MyText",
        :course_id => @course.id,
        :day => Time.now
      )
    ])
  end

  it "renders a list of notes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => @course.name.to_s, :count => 2
  end
end
