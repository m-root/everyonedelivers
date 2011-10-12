  function mapinitialize(start_lat, start_long, draggable) {
    var start = new google.maps.LatLng(start_lat, start_long);
    var map = new google.maps.Map(document.getElementById("gmap"),
                                  {mapTypeId: google.maps.MapTypeId.ROADMAP,
                                   center: start,
                                   zoom: 12});
    var marker_start = new google.maps.Marker({position:start,
                                               draggable: draggable});
    if(draggable) {
      google.maps.event.addListener(marker_start, 'dragend', mark_dragged);
    }

    marker_start.setMap(map);
    return map;
  }

  function map_destination(map, end_lat, end_long, units) {
    var start = map.getCenter();
    var end = new google.maps.LatLng(end_lat, end_long);
    var bounds = new google.maps.LatLngBounds();
    bounds.extend(start);
    bounds.extend(end);
    map.fitBounds(bounds);

    var marker_end = new google.maps.Marker({position:end});
    marker_end.setMap(map);
     

    var directions = new google.maps.DirectionsService();
    var request = { origin : start,
                    destination : end,
                    travelMode : google.maps.DirectionsTravelMode.DRIVING,
                    unitSystem: units };
    directions.route(request, show_directions_callback_builder(map));
  }

  function mark_dragged(event) {
    document.getElementById("gmaplat").value = event.latLng.Ma;
    document.getElementById("gmaplng").value = event.latLng.Na;
  }

  function show_directions_callback_builder(map) {
    // use a closure to make map a local variable
    return function show_directions(result, status) {
      if(status == "NOT_FOUND") {
        $('#gmaperror').html("Route not found");
      }
      if(status == "OK") {
        renderer = new google.maps.DirectionsRenderer({directions: result,
                                                       suppressMarkers : true});
        renderer.setMap(map);
        $('#travel_distance').html(result.routes[0].legs[0].distance.text)
      }
    }
  }
