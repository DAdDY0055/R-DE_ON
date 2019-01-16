$(function() {

  const currentPASS = $(location).attr('pathname');
  const spotregex = new RegExp(/spots\/\d+/); //spotsのshowのurlの正規表現
  const userregex = new RegExp(/users\/\d+/); //usersのshowのurlの正規表現

  if(currentPASS  == '/spots' || currentPASS  == '/' || spotregex.test(currentPASS) || userregex.test(currentPASS) ) {
    handler = Gmaps.build('Google');
    handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
      // gonで受け取った変数を定義
      const map_hash      = gon.map_hash
      const map_latitude  = gon.map_latitude 
      const map_longitude = gon.map_longitude
      const map_zoon      = gon.map_zoon
  
      markers = handler.addMarkers(map_hash);
      handler.bounds.extendWith(markers);
      handler.fitMapToBounds();
      handler.getMap().setCenter(new google.maps.LatLng(map_latitude, map_longitude));
      handler.getMap().setZoom(map_zoon);
    });
  }
});
