class CallsController < ApplicationController

  def index 
    @calls = Call.paginate(page: params[:page], per_page: 20)
    @hash = Gmaps4rails.build_markers(@calls) do |call, marker|
      marker.lat call.latitude
      marker.lng call.longitude
      marker.title call.call_type
      marker.infowindow "<b>#{call.call_type}</b>
                         <p>#{call.address}</p>
                         <i>Call last updated on: #{call.call_last_updated.strftime("%B %d, %Y %I:%M %p %Z")}</i>"
    end
  end
end
