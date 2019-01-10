document.addEventListener('turbolinks:load', function initMap() {
  // gonで受け取った変数を定義
  var spot_latitude  = gon.spot_latitude
  var spot_longitude = gon.spot_longitude
  var spot_address   = gon.spot_address

  var location ={lat: spot_latitude, lng: spot_longitude};
  var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 15,
      center: location
  });
  var transitLayer = new google.maps.TransitLayer();
  transitLayer.setMap(map);
  var contentString = "住所：spot_address";
  var infowindow = new google.maps.InfoWindow({
      content: contentString
  });
  var marker = new google.maps.Marker({
      position:location,
      map: map,
      title: contentString
  });
  marker.addListener('click', function() {
      infowindow.open(map, marker);
  });
});
