setMap = (address, latitude, longitude, zoom) ->
  $("#map_canvas").googleMaps
    address: address
    latitude: ""
    longitude: ""
    collback: (latitude, longitude) ->
      $("#place_latitude").val latitude
      $("#place_longitude").val longitude
    zoom_collback: (zoom) ->
      $("#place_zoom_level").val zoom
  ,
    zoom : zoom

drawMap = (id, latitude, longitude, zoom) ->
  $(id).googleMaps
    latitude: latitude
    longitude: longitude
    markerDrag: false
  ,
    zoom : zoom

$ ->
  $("#search").on 'click', (event) ->
    address = $('#place_address').val()
    zoom = parseInt($('#place_zoom_level').val())
    setMap(address,"","", zoom)

  $("#place_postcode").on 'keyup', (event) ->
    AjaxZip3.zip2addr(this,'','place[prefecture]','place[address]')

  if $('#data_attr').data('path') == 'place_index'
    for place in $('#data_attr').data('places')
      drawMap("#map_canvas" + place.id, place.latitude, place.longitude, place.zoom_level)

  if $('#data_attr').data('path') == 'place_show'
    place = $('#data_attr').data('place')
    drawMap("#map_canvas" + place.id, place.latitude, place.longitude, place.zoom_level)

  if $('#data_attr').data('path') == 'place_edit'
    $("#search").click()
