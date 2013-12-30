require "rspec/autorun"
require "./spec/spec_helper"

describe Call do
  
  its(:call_type) { should be_nil }
  its(:address) { should be_nil }

  it "converts XML in to calls" do
    Call.import_from_xml_uri(File.open("spec/fixtures/call_data_1.cfm"))
    call_attributes = Call.all.map { |call| call.attributes.values_at("call_type", "address") }
    call_attributes.should == [
    ["PERSON CONTACT (86)", "19600 BLOCK OF NE GLISAN ST, GRESHAM, OR"],
    ["TRAFFIC STOP", "SE 80TH AVE / SE GLADSTONE ST, PORTLAND, OR"],
    ["WARRANT", "19100 BLOCK OF E BURNSIDE ST, GRESHAM, OR"]
    ]
  end

  it 'gets XML from a remote server' do
    VCR.use_cassette('xml_data') do
      Call.import_from_xml_uri("http://www.portlandonline.com/scripts/911incidents.cfm")
      Call.count.should == 100
      Call.first.attributes.should include("call_type" => "UNDESCRIBED INCIDENT")
      Call.first.attributes.should include("address" => "2400 BLOCK OF NW BURNSIDE CT, GRESHAM, OR")
      Call.first.attributes.should include("call_id" => "PG13000072425")
    end
  end

  it 'should have a unique call_id' do
    Call.import_from_xml_uri(File.open("spec/fixtures/call_data_1.cfm"))
    Call.import_from_xml_uri(File.open("spec/fixtures/call_data_2.cfm"))
    Call.count.should == 4
  end
end
