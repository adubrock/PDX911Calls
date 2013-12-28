require "rspec/autorun"
require "./spec/spec_helper"

describe Call do

  its(:call_type) { should be_nil }
  its(:address) { should be_nil }
  
  it "converts XML in to calls" do
    Call.create_from_xml('spec/fixtures/call_data.cfm')
    Call.count.should == 3
  end

  it 'pulls the call_type from the XML' do
    Call.create_from_xml('spec/fixtures/call_data.cfm')
    Call.first.attributes.should include("call_type" => "PERSON CONTACT (86)")
    Call.last.attributes.should include("call_type" => "WARRANT")
  end

  it 'pulls the address from the XML' do
    Call.create_from_xml('spec/fixtures/call_data.cfm')
    Call.first.attributes.should include("address" => "19600 BLOCK OF NE GLISAN ST, GRESHAM, OR")
    Call.last.attributes.should include("address" => "19100 BLOCK OF E BURNSIDE ST, GRESHAM, OR")
  end
end
