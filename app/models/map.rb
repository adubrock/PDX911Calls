class Map
  def self.markers(calls)
    calls.map do |call|
      { 
        callId: call.call_id,
        lat: call.latitude,
        lng: call.longitude,
        title: call.call_type,
        infoWindow: "<b>#{call.call_type}</b>
                         <p>#{call.address}</p>
                         <i>Call last updated at: #{call.updated_at.strftime("%B %d, %Y %I:%M %p %Z")}</i>"
      }
    end
  end
end
