require "rspec/autorun"
require "./spec/spec_helper"

describe Call do

  its(:call_id) { should be_nil }
  its(:call_type) { should be_nil }
  its(:address) { should be_nil }
  its(:agency) { should be_nil }
  its(:updated_at) { should be_nil }
  its(:latitude) { should be_nil }
  its(:longitude) { should be_nil }

  it 'gets XML from a remote server' do
    VCR.use_cassette('xml_data') do
      Call.import_from_xml_uri("http://www.portlandonline.com/scripts/911incidents.cfm")
      Call.count.should == 100
      Call.find_by_call_id("PG13000072425").attributes.should include("address" => "2400 BLOCK OF NW BURNSIDE CT, GRESHAM, OR",
                                           "agency" => "Gresham Police",
                                           "call_id" => "PG13000072425",
                                           "updated_at" => "Sat, 28 Dec 2013 17:47:10 PST -08:00",
                                           "call_type" => "UNDESCRIBED INCIDENT",
                                           "latitude" => 45.514193,
                                           "longitude" => -122.457471)
    end
  end

  it 'should only create one instance per call_id' do
    Call.import_from_xml_uri("spec/fixtures/call_data_1.cfm")
    Call.import_from_xml_uri("spec/fixtures/call_data_2.cfm")
    Call.count.should == 4
  end

  it 'should pull the call_type' do
    Call.import_from_xml_uri("spec/fixtures/call_data_1.cfm")
    Call.first.call_type.should == "PERSON CONTACT (86)"
    Call.last.call_type.should == "WARRANT"
  end

  it 'should pull the address' do
    Call.import_from_xml_uri("spec/fixtures/call_data_1.cfm")
    Call.first.address.should == "19600 BLOCK OF NE GLISAN ST, GRESHAM, OR"
    Call.last.address.should == "19100 BLOCK OF E BURNSIDE ST, GRESHAM, OR"
  end

  it 'should pull the agency' do
    Call.import_from_xml_uri("spec/fixtures/call_data_1.cfm")
    Call.first.agency.should == "Gresham Police"
    Call.last.agency.should == "Gresham Police"
  end

  it 'should pull the updated_at' do
    Call.import_from_xml_uri("spec/fixtures/call_data_1.cfm")
    Call.first.updated_at.should == "Tue, 17 Dec 2013 04:01:53 PST -08:00"
    Call.last.updated_at.should == "Tue, 17 Dec 2013 03:56:16 PST -08:00"
  end

  it 'should pull the call_id' do
    Call.import_from_xml_uri("spec/fixtures/call_data_1.cfm")
    Call.first.call_id.should == "PG13000069982"
    Call.last.call_id.should == "PG13000069981"
  end

  it 'should pull the latitude' do
    Call.import_from_xml_uri("spec/fixtures/call_data_1.cfm")
    Call.first.latitude.should == 45.525665
    Call.last.latitude.should == 45.517932
  end

  it 'should pull the longitude' do
    Call.import_from_xml_uri("spec/fixtures/call_data_1.cfm")
    Call.first.longitude.should == -122.460767
    Call.last.longitude.should == -122.466783
  end

  it "sorts the calls by date and time" do
    Call.import_from_xml_uri("spec/fixtures/call_data_3.cfm")
    Call.first.updated_at.should == "Sat, 04 Jan 2014 11:39:19 PST -08:00"
    Call.last.updated_at.should == "Sat, 04 Jan 2014 10:51:44 PST -08:00"
  end
end
