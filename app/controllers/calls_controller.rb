class CallsController < ApplicationController

  def index
    @calls = Call.paginate(page: params[:page], per_page: 20)
    @hash = Map.markers
  end
end
