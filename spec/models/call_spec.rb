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

  it 'gets XML from a remote server' do
    VCR.use_cassette('xml_data') do
      Call.import_from_xml_uri("http://www.portlandonline.com/scripts/911incidents.cfm")
      Call.count.should == 100
      Call.first.attributes.should include("address" => "2400 BLOCK OF NW BURNSIDE CT, GRESHAM, OR",
                                           "agency" => "Gresham Police",
                                           "call_id" => "PG13000072425",
                                           "call_last_updated" => "12/28/13 5:47:10 PM PST",
                                           "call_type" => "UNDESCRIBED INCIDENT",
                                           "latitude" => 45.514193,
                                           "longitude" => -122.457471)
    end
  end

  it 'should only create one instance per call_id' do
    Call.import_from_xml_uri(File.open("spec/fixtures/call_data_1.cfm"))
    Call.import_from_xml_uri(File.open("spec/fixtures/call_data_2.cfm"))
    Call.count.should == 4
  end

  it 'should pull the call_type' do
    Call.import_from_xml_uri(File.open("spec/fixtures/call_data_1.cfm"))
    Call.first.call_type.should == "PERSON CONTACT (86)"
    Call.last.call_type.should == "WARRANT"
  end  

  it 'should pull the address' do
    Call.import_from_xml_uri(File.open("spec/fixtures/call_data_1.cfm"))
    Call.first.address.should == "19600 BLOCK OF NE GLISAN ST, GRESHAM, OR"
    Call.last.address.should == "19100 BLOCK OF E BURNSIDE ST, GRESHAM, OR"
  end

  it 'should pull the agency' do
    Call.import_from_xml_uri(File.open("spec/fixtures/call_data_1.cfm"))
    Call.first.agency.should == "Gresham Police"
    Call.last.agency.should == "Gresham Police"
  end

  it 'should pull the call_last_updated' do
    Call.import_from_xml_uri(File.open("spec/fixtures/call_data_1.cfm"))
    Call.first.call_last_updated.should == "12/17/13 4:01:53 AM PST"
    Call.last.call_last_updated.should == "12/17/13 3:56:16 AM PST"
  end

  it 'should pull the call_id' do
    Call.import_from_xml_uri(File.open("spec/fixtures/call_data_1.cfm"))
    Call.first.call_id.should == "PG13000069982"
    Call.last.call_id.should == "PG13000069981"
  end

  it 'should pull the latitude' do
    Call.import_from_xml_uri(File.open("spec/fixtures/call_data_1.cfm"))
    Call.first.latitude.should == 45.525665
    Call.last.latitude.should == 45.517932
  end
  
  it 'should pull the longitude' do
    Call.import_from_xml_uri(File.open("spec/fixtures/call_data_1.cfm"))
    Call.first.longitude.should == -122.460767
    Call.last.longitude.should == -122.466783
  end
end
