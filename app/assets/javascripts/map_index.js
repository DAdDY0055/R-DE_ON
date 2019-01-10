document.addEventListener('turbolinks:load', function initMap() {
  handler = Gmaps.build('Google');
  handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){

    // gonで受け取った変数を定義
    var map_hash      = gon.map_hash
    var map_latitude  = gon.map_latitude 
    var map_longitude = gon.map_longitude
    var map_zoon      = gon.map_zoon

    handler.bounds.extendWith(markers);
    console.log(map_hash);
    console.log(markers);
    handler.fitMapToBounds();
    handler.getMap().setCenter(new google.maps.LatLng(map_latitude, map_longitude));
    handler.getMap().setZoom(map_zoon);
  });
});
