require 'spec_helper'

describe 'index' do
  it 'displays the last 100 calls' do
    (@calls.count).should == 100    
  end

  it 'has valid data' do
    @calls.should include("PP13000411200")
  end
end
