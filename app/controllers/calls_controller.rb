class CallsController < ApplicationController

  def index
    @calls = Call.paginate(page: params[:page], per_page: 20)
    @markers = Map.markers(@calls)
  end
end
