require 'rspec/autorun'
require './spec/spec_helper'

module Page
  class Call < Struct.new(:call_type, :address, :agency, :call_last_updated, :call_id, :latidude, :longitude)
  end
end

describe 'homepage' do

  it 'converts XML into a list of calls' do
    Call.import_from_xml_uri("spec/fixtures/call_data_1.cfm")

    visit "/"

    calls.should == [
<<<<<<< HEAD
      ["Type",                "Address",                                     "Agency",          "Call Last Updated",       "Call ID #",     "Latitude",  "Longitude"],
      ["PERSON CONTACT (86)", "19600 BLOCK OF NE GLISAN ST, GRESHAM, OR",    "Gresham Police",  "2013-12-17 04:01:53 -0800", "PG13000069982", "45.525665", "-122.460767"],
      ["TRAFFIC STOP",        "SE 80TH AVE / SE GLADSTONE ST, PORTLAND, OR", "Portland Police", "2013-12-17 03:56:31 -0800", "PP13000411200", "45.492759", "-122.580967"],
      ["WARRANT",             "19100 BLOCK OF E BURNSIDE ST, GRESHAM, OR",   "Gresham Police",  "2013-12-17 03:56:16 -0800", "PG13000069981", "45.517932", "-122.466783"],
=======
      {call_type: "PERSON CONTACT (86)", address: "19600 BLOCK OF NE GLISAN ST, GRESHAM, OR",    agency: "Gresham Police",  call_last_updated: "12/17/13 4:01:53 AM PST", call_id: "PG13000069982", latitude: "45.525665", longitude: "-122.460767"},
      {call_type: "TRAFFIC STOP",        address: "SE 80TH AVE / SE GLADSTONE ST, PORTLAND, OR", agency: "Portland Police", call_last_updated: "12/17/13 3:56:31 AM PST", call_id: "PP13000411200", latitude: "45.492759", longitude: "-122.580967"},
      {call_type: "WARRANT",             address: "19100 BLOCK OF E BURNSIDE ST, GRESHAM, OR",   agency: "Gresham Police",  call_last_updated: "12/17/13 3:56:16 AM PST", call_id: "PG13000069981", latitude: "45.517932", longitude: "-122.466783"},
>>>>>>> 5aae6eb62f37a94d102307faf3086d00d37dcf0f
    ]
  end

  it 'should list the 20 newest calls, newest to oldest' do
    Call.import_from_xml_uri("spec/fixtures/call_data_3.cfm")
  
    visit "/"
    
    calls.count.should == 20
    calls.first[:call_last_updated].should == "1/4/14 11:39:19 AM PST"
    calls.last[:call_last_updated].should == "1/4/14 11:15:46 AM PST"
  end

  it 'should have a map' do
    visit "/"
    page.should have_css('div.map')
  end

#  it 'should have a search function' do
#    visit "/"
#    page.should have_css('div.search')
#  end

  def calls
    all(".calls tbody tr").map do |row|
      row_data = row.all("td").map do |cell|
        cell.text
      end
      {call_type: row_data[0], address: row_data[1], agency: row_data[2], call_last_updated: row_data[3], call_id: row_data[4], latitude: row_data[5], longitude: row_data[6]}
    end
  end
end
    
