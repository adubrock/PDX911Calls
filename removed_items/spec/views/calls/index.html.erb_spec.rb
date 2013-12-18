require 'spec_helper'

describe "calls/index" do
  before(:each) do
    assign(:calls, [
      stub_model(Call,
        :call_id => "Call",
        :call_type => "Call Type",
        :address => "Address",
        :agency => "Agency",
        :latitude => 1.5,
        :longitude => 1.5,
        :last_updated => "Last Updated"
      ),
      stub_model(Call,
        :call_id => "Call",
        :call_type => "Call Type",
        :address => "Address",
        :agency => "Agency",
        :latitude => 1.5,
        :longitude => 1.5,
        :last_updated => "Last Updated"
      )
    ])
  end

  it "renders a list of calls" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Call".to_s, :count => 2
    assert_select "tr>td", :text => "Call Type".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Agency".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Last Updated".to_s, :count => 2
  end
end
