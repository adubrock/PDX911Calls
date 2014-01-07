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
    visit "/"
    page.should have_field('address')
    page.should have_field('zip')
    page.should have_select('start_date_year', :selected => '2014')
    page.should have_select('start_date_month', :selected => 'January')
    page.should have_select('start_date_day', :selected => '6')
    page.should have_select('end_date_year', :selected => '2014')
    page.should have_select('end_date_month', :selected => 'January')
    page.should have_select('end_date_day', :selected => '6')
    page.should have_button('Search')
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

