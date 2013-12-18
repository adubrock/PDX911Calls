require 'spec_helper'

describe "calls/show" do
  before(:each) do
    @call = assign(:call, stub_model(Call,
      :call_id => "Call",
      :call_type => "Call Type",
      :address => "Address",
      :agency => "Agency",
      :latitude => 1.5,
      :longitude => 1.5,
      :last_updated => "Last Updated"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Call/)
    rendered.should match(/Call Type/)
    rendered.should match(/Address/)
    rendered.should match(/Agency/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/Last Updated/)
  end
end
