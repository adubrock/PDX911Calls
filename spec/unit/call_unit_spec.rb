require 'spec_helper'

describe "Call" do
  
  before do
    @call = Call.new(call_id: "PG13000069982", call_type: "PERSON CONTACT (86)", 
                     address: "19600 BLOCK OF NE GLISAN ST, GRESHAM, OR", agency: "Gresham Police",
                     latitude: "45.525665", longitude: "-122.460767", date_time: "12/17/13 4:01:53 AM PST")
  end

  it 'should have a call_id' do
    @call.should have_text("PG13000069982")
  end
end
