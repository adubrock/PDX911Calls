class Map

  def self.markers(calls)
    Gmaps4rails.build_markers(calls) do |call, marker|
      marker.lat call.latitude
      marker.lng call.longitude
      marker.title call.call_type
      marker.infowindow "<b>#{call.call_type}</b>
                         <p>#{call.address}</p>
                         <i>Call last updated at: #{call.updated_at.strftime("%B %d, %Y %I:%M %p %Z")}</i>"
    end
  end
end
