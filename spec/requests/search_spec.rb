require 'rspec/autorun'
require './spec/spec_helper'

describe 'search' do
  
  it 'searches the agency field' do
    Call.import_from_xml_uri("spec/fixtures/call_data_3.cfm")
    Call.where("agency LIKE '%Fire%'").count.should == 5
  end
end

# describe 'search' do
#   before { visit root_path }

#   describe "with invalid information" do

#     describe "with invalid address" do
#       before { fill_in 'address',  with: "Invalid Address" }
#       it "should provide an error message and no search results" do
#         expect { click_button "Search" }.to have_content('invalid address')
#       end
#     end

#     describe "error messages" do
#       before { click_button "Search" }
#       it { should have_content('error') }
#     end
  # end

#   describe "with valid information" do

#     describe "with valid address"
#       before { fill_in 'address', with: "4000 NE Fremont" }
#       it "should provide search results" do
#         expect { click_button "Search" }.to #something
#       end
#     end
#   end
  
# end