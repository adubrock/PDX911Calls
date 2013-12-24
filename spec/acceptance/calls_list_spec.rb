require 'rspec/autorun'
require './spec/spec_helper'

describe 'homepage' do
  it 'should show a list of calls' do
    Call.create! call_type: "PERSON CONTACT (86)", address: "19600 BLOCK OF NE GLISAN ST, GRESHAM, OR"
    Call.create! call_type: "TRAFFIC STOP",        address: "SE 80TH AVE / SE GLADSTONE ST, PORTLAND, OR"
    Call.create! call_type: "WARRANT",             address: "19100 BLOCK OF E BURNSIDE ST, GRESHAM, OR"

    visit "/"

    calls.should == [
      ["Type",                "Address"],
      ["PERSON CONTACT (86)", "19600 BLOCK OF NE GLISAN ST, GRESHAM, OR"],
      ["TRAFFIC STOP",        "SE 80TH AVE / SE GLADSTONE ST, PORTLAND, OR"],
      ["WARRANT",             "19100 BLOCK OF E BURNSIDE ST, GRESHAM, OR"],
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

