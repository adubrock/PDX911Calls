require 'rspec/autorun'
require './spec/spec_helper'

describe 'homepage' do
  it 'should show a list of calls' do
    visit "/"
    calls.should == [
      ["Type",                "Address"],
      ["PERSON CONTACT (86)", "19600 BLOCK OF NE GLISAN ST, GRESHAM, OR"],
      ["TRAFFIC STOP",        "SE 80TH AVE / SE GLADSTONE ST, PORTLAND, OR"],
      ["WARRANT",             "19100 BLOCK OF E BURNSIDE ST, GRESHAM, OR"],
      ["NOISE DISTURBANCE",   "2300 BLOCK OF SE TAYLOR ST, PORTLAND, OR"],
      ["TRAFFIC STOP",        "NW 257TH AVE / NW 257TH WAY, TROUTDALE, OR"],
    ]
  end

  def calls
    all(".calls tr").map do |row|
      row.all("th,td").map do |cell|
        cell.text
      end
    end
  end
end

