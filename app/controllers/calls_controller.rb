class CallsController < ApplicationController
  def index
    @calls = Call.paginate(page: params[:page], per_page: 20)
    @calls = @calls.search(params[:search]) if params[:search]
    @markers = Map.markers(@calls)
  end
end

