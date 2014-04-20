google.maps.createMap = function(element, markerAttributes) {
  this.map = new this.Map(element, { scrollwheel: false });
  this.map.markers = [];
  this.map.bounds = new google.maps.LatLngBounds();
  
  var self = this;
  markerAttributes.forEach(function(attributes) {
    var marker = self.map.createMarker(attributes);
    self.map.bounds.extend(marker.position);
  });
    
  this.map.fitBounds(this.map.bounds);
  return this.map;
}

google.maps.Map.prototype.createMarker = function(attributes) {
  var marker = new google.maps.Marker({
    position: new google.maps.LatLng(attributes.lat, attributes.lng),
    map: this,
    title: attributes.title,
    callId: attributes.callId
  });

  marker.createInfoWindow(attributes.infoWindow);
  google.maps.map.markers.push(marker);

  return marker;
}

google.maps.Marker.prototype.createInfoWindow = function(content) {
  this.infoWindow = new google.maps.InfoWindow({ content: content });

  google.maps.event.addListener(this, 'click', function() {
    this.map.setCenter(this.getPosition());
    this.infoWindow.open(this.map, this);
    if(this.map.openInfoWindow) { this.map.openInfoWindow.close(); }
    this.map.openInfoWindow = this.infoWindow;
  });
};
