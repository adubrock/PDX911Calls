require 'rspec/autorun'
require './spec/spec_helper'

describe 'homepage' do

  it 'converts XML into a list of calls' do
    Call.import_from_xml_uri(File.open("spec/fixtures/call_data_1.cfm"))

    visit "/"

    calls.should == [
      ["Type",                "Address",                                     "Agency",          "Call Last Updated",       "Call ID #",     "Latitude",  "Longitude"],
      ["PERSON CONTACT (86)", "19600 BLOCK OF NE GLISAN ST, GRESHAM, OR",    "Gresham Police",  "12/17/13 4:01:53 AM PST", "PG13000069982", "45.525665", "-122.460767"],
      ["TRAFFIC STOP",        "SE 80TH AVE / SE GLADSTONE ST, PORTLAND, OR", "Portland Police", "12/17/13 3:56:31 AM PST", "PP13000411200", "45.492759", "-122.580967"],
      ["WARRANT",             "19100 BLOCK OF E BURNSIDE ST, GRESHAM, OR",   "Gresham Police",  "12/17/13 3:56:16 AM PST", "PG13000069981", "45.517932", "-122.466783"],
    ]
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
    all(".calls tr").map do |row|
      row.all("th,td").map do |cell|
        cell.text
      end
    end
  end
end
