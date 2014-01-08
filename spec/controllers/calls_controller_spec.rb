require 'rspec/autorun'
require './spec/spec_helper'

describe CallsController do

  describe "#index" do
    it "sets a calls and markers instance variables" do
      calls = [1,2,3]
      maps = ["a","b","c"]
      Call.stub(paginate: calls)
      Map.stub(markers: maps)

      get :index

      assigns(:calls).should == calls
      assigns(:markers).should == maps
    end
  end
end
