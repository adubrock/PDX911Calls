require 'spec_helper'

describe 'index' do
  
#  let(:call) { FactoryGirl.create(:call) }

  it 'should have 100 things' do
    visit "/"
    page.should have_css(".call", count: 100)
    page.should have_text("PG13000069969")
    page.should have_text("SE 80TH AVE / SE GLADSTONE ST, PORTLAND, OR")
  end
end

=begin
describe 'index' do
  it 'displays the last 100 calls' do
    @calls.count.should == 100    
  end

  it 'has valid data' do
    @calls.should include("PP13000411200")
  end
end
=end