class CallsController < ApplicationController

  def index
  end

  def new
    @call = Call.new
  end

end
