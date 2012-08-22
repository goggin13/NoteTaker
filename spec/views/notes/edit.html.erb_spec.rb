require 'spec_helper'

describe "notes/edit" do
  before(:each) do
    @note = assign(:note, stub_model(Note,
      :title => "MyString",
      :body => "MyText",
      :course_id => 1
    ))
  end

  it "renders the edit note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => notes_path(@note), :method => "post" do
      assert_select "input#note_title", :name => "note[title]"
      assert_select "textarea#note_body", :name => "note[body]"
      assert_select "select#note_course_id", :name => "note[course_id]"
    end
  end
end
