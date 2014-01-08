require 'rspec/autorun'
require './spec/spec_helper'

describe CallsController do

  describe "#index" do
    it "sets a calls instance variable" do
      calls = [1,2,3]
      Call.stub(paginate: calls)

      get :index

      assigns(:calls).should == calls
    end
  end
end
