require 'spec_helper'

describe "notes/show" do
  before(:each) do
    @note = assign(:note, stub_model(Note,
      :title => "Title",
      :body => "MyText",
      :course_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end
