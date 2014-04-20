//= require jquery
//= require google_maps

var map;
$.fn.map = function(markerAttributes) {
  map = google.maps.createMap(this[0], markerAttributes);
}

$(".calls tr").click(function() {
  var callId = $(this).find(".call_id").text();
  map.markers.forEach(function(marker) {
    if(marker.callId === callId) {
      google.maps.event.trigger(marker, "click")
      document.body.scrollTop = 0;
    }
  });
});

