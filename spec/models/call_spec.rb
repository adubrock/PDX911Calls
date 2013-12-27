require "rspec/autorun"
require "./spec/spec_helper"

describe Call do

  its(:call_type) { should be_nil }
  its(:address) { should be_nil }
  
  it "converts XML in to calls" do
    Call.create_from_xml('./fixtures/call_data.cfm')
    Call.count.should == 3
    Call.first.attributes.should include("call_type" => "PERSON CONTACT (86)")
  end
end
