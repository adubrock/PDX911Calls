google.maps.event.addDomListener(window, 'load', function initialize() {

  var map = new google.maps.Map(document.getElementById("map"));
  var bounds = new google.maps.LatLngBounds();
  var focusedInfoWindow;

  var markers = markerAttributes.map(function(attributes) {
    var myLatlng = new google.maps.LatLng(attributes.lat, attributes.lng);
    bounds.extend(myLatlng);

    var marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      title: attributes.title
    });

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
  })

  map.fitBounds(bounds);
});

