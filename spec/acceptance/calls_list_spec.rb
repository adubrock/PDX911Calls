require 'rspec/autorun'
require './spec/spec_helper'

describe 'homepage' do

  it 'converts XML into a list of calls' do
    Call.import_from_xml_uri("spec/fixtures/call_data_1.cfm")

    visit "/"

    calls.should == [
      { call_type: "PERSON CONTACT (86)", address: "19600 BLOCK OF NE GLISAN ST, GRESHAM, OR",    agency: "Gresham Police",  updated_at: "December 17, 2013 04:01 AM PST", call_id: "PG13000069982" },
      { call_type: "TRAFFIC STOP",        address: "SE 80TH AVE / SE GLADSTONE ST, PORTLAND, OR", agency: "Portland Police", updated_at: "December 17, 2013 03:56 AM PST", call_id: "PP13000411200" },
      { call_type: "WARRANT",             address: "19100 BLOCK OF E BURNSIDE ST, GRESHAM, OR",   agency: "Gresham Police",  updated_at: "December 17, 2013 03:56 AM PST", call_id: "PG13000069981" },
    ]
  end

  it 'should list the 20 newest calls, newest to oldest' do
    Call.import_from_xml_uri("spec/fixtures/call_data_3.cfm")

    visit "/"

    calls.count.should == 20
    calls.first[:updated_at].should == "January 04, 2014 11:39 AM PST"
    calls.last[:updated_at].should == "January 04, 2014 11:15 AM PST"
  end

  it 'should have a map' do
    visit "/"
    page.should have_css('div.map')
  end

  it 'should have a search function' do
    Call.import_from_xml_uri("spec/fixtures/call_data_3.cfm")

    visit "/"
    fill_in('search', :with => 'fire')
    click_on('→')

    calls.should == [
      { call_type: "MED - MEDICAL", address: "0 CONCOURSE A PIA , PORTLAND, OR", agency: "Portland Fire", updated_at: "January 04, 2014 11:27 AM PST", call_id: "RP14000000816" },
      { call_type: "TA1PED - TRAFFIC ACCIDENT - PEDESTRIAN OR BIKE", address: "NE MARTIN LUTHER KING JR BLVD / NE COUCH ST, PORTLAND, OR", agency: "Portland Fire", updated_at: "January 04, 2014 11:26 AM PST", call_id: "RP14000000818" },
      { call_type: "MED - MEDICAL", address: "3100 BLOCK OF SE POWELL BLVD, PORTLAND, OR", agency: "Portland Fire", updated_at: "January 04, 2014 11:18 AM PST", call_id: "RP14000000815" },
      { call_type: "MED - MEDICAL", address: "0 CONCOURSE C PIA , PORTLAND, OR", agency: "Portland Fire",  updated_at: "January 04, 2014 11:16 AM PST", call_id: "RP14000000813" },
      { call_type: "MED - MEDICAL", address: "0 CONCOURSE A PIA , PORTLAND, OR", agency: "Airport Fire", updated_at: "January 04, 2014 11:13 AM PST", call_id: "RA14000000023" },
    ]
  end

  def calls
    all(".calls tbody tr").map do |row|
      row_data = row.all("td").map do |cell|
        cell.text
      end
      { call_type: row_data[0], address: row_data[1], agency: row_data[2], updated_at: row_data[3], call_id: row_data[4] }
    end
  end
end
