require 'rspec/autorun'
require './spec/spec_helper'

describe CallsController do
  let(:call1) { FactoryGirl.create(:call) }
  let(:call2) { FactoryGirl.create(:call) }
  let(:call3) { FactoryGirl.create(:call) }

  describe "#index" do
    it "sets a calls instance variable" do

      calls = [call1, call2, call3]
      Call.stub(paginate: calls)

      get :index

      assigns(:calls).should == calls
    end
  end
end
