//= require jquery

var markers;

google.maps.event.addDomListener(window, 'load', function initialize() {

  var map = new google.maps.Map(document.getElementById("map"));
  var bounds = new google.maps.LatLngBounds();
  var focusedInfoWindow;

  markers = markerAttributes.map(function(attributes) {
    var myLatlng = new google.maps.LatLng(attributes.lat, attributes.lng);
    bounds.extend(myLatlng);

    var marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      title: attributes.title
    });

    marker.callId = attributes.callId;

    var infoWindow = new google.maps.InfoWindow({
      content: attributes.infoWindow
    });

    google.maps.event.addListener(marker, 'click', function() {
      infoWindow.open(map,marker);
      if(focusedInfoWindow) {
        focusedInfoWindow.close();
      }
      focusedInfoWindow = infoWindow;
    });

    return marker;
  })

  map.fitBounds(bounds);
});

$(".calls tr").click(function() {
  var callId = $(this).find(".call_id").text();
  markers.forEach(function(marker) {
    if(marker.callId === callId) {
      google.maps.event.trigger(marker, "click")
    }
  });
});
