require 'spec_helper'

describe "calls/new" do
  before(:each) do
    assign(:call, stub_model(Call,
      :call_id => "MyString",
      :call_type => "MyString",
      :address => "MyString",
      :agency => "MyString",
      :latitude => 1.5,
      :longitude => 1.5,
      :last_updated => "MyString"
    ).as_new_record)
  end

  it "renders new call form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", calls_path, "post" do
      assert_select "input#call_call_id[name=?]", "call[call_id]"
      assert_select "input#call_call_type[name=?]", "call[call_type]"
      assert_select "input#call_address[name=?]", "call[address]"
      assert_select "input#call_agency[name=?]", "call[agency]"
      assert_select "input#call_latitude[name=?]", "call[latitude]"
      assert_select "input#call_longitude[name=?]", "call[longitude]"
      assert_select "input#call_last_updated[name=?]", "call[last_updated]"
    end
  end
end
