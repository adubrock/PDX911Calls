class CallsController < ApplicationController

  def index 
    @calls = Call.paginate(page: params[:page], per_page: 20)
    @hash = Gmaps4rails.build_markers(@calls) do |call, marker|
      marker.lat call.latitude
      marker.lng call.longitude
      marker.title call.call_type
      marker.infowindow "#{call.call_type}\n#{call.call_last_updated}"
    end
  end
end
