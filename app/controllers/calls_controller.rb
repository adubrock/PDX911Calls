class CallsController < ApplicationController
  def index
    @calls = Call.all
#    @hash = Gmaps4rails.build_markers(@calls) do |call, marker|
#      marker.lat call.latitude
#      marker.lng call.longitude
#      marker.title call.call_id
#    end
  end
end
