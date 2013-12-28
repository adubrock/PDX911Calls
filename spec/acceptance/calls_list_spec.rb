require 'rspec/autorun'
require './spec/spec_helper'

describe 'homepage' do

  it 'converts XML in to a list of calls' do
    Call.create_from_xml('spec/fixtures/call_data.cfm')

    visit "/"

    calls.should == [
      ["Type",                "Address"],
      ["PERSON CONTACT (86)", "19600 BLOCK OF NE GLISAN ST, GRESHAM, OR"],
      ["TRAFFIC STOP",        "SE 80TH AVE / SE GLADSTONE ST, PORTLAND, OR"],
      ["WARRANT",             "19100 BLOCK OF E BURNSIDE ST, GRESHAM, OR"],
    ]
  end

  it 'gets XML from a remote server' do

  end

  def calls
    all(".calls tr").map do |row|
      row.all("th,td").map do |cell|
        cell.text
      end
    end
  end
end
