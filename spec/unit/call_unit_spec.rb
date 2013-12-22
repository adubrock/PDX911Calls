require 'spec_helper'

describe 'call' do
  it 'should exist' do
    call.should have_text("PG13000069969")
  end
end
