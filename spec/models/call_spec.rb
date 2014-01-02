require "rspec/autorun"
require "./spec/spec_helper"

describe Call do
  
  its(:call_id) { should be_nil }
  its(:call_type) { should be_nil }
  its(:address) { should be_nil }
  its(:agency) { should be_nil }
  its(:call_last_updated) { should be_nil }
  its(:latitude) { should be_nil }
  its(:longitude) { should be_nil }

  it "converts XML into calls" do
    Call.import_from_xml_uri(File.open("spec/fixtures/call_data_1.cfm"))
    call_attributes = Call.all.map { |call| call.attributes.values_at("call_type", "address", "agency", "call_last_updated", "call_id") }
    call_attributes.should == [
    ["PERSON CONTACT (86)", "19600 BLOCK OF NE GLISAN ST, GRESHAM, OR", "Gresham Police", "12/17/13 4:01:53 AM PST", "PG13000069982"],
    ["TRAFFIC STOP", "SE 80TH AVE / SE GLADSTONE ST, PORTLAND, OR", "Portland Police", "12/17/13 3:56:31 AM PST", "PP13000411200"],
    ["WARRANT", "19100 BLOCK OF E BURNSIDE ST, GRESHAM, OR", "Gresham Police", "12/17/13 3:56:16 AM PST", "PG13000069981"]
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

  it 'should pull the latitude and longitude' do
    Call.import_from_xml_uri(File.open("spec/fixtures/call_data_1.cfm"))
    Call.first.latitude.should == 45.525665
    Call.first.longitude.should == -122.460767
  end
end
