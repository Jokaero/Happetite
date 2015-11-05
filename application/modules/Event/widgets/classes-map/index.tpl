<style>
      #map-canvas{
        height: 200px;
      }
</style>

<?php if ($this->event) : ?>
<?php
    $address = $this->event->country . ' '
    . $this->event->city . ' '
    . $this->event->zipcode . ' '
    . $this->event->address;
?>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>

<script>
var geocoder;
var map;
function initialize() {
  geocoder = new google.maps.Geocoder();
  var latlng = new google.maps.LatLng(-34.397, 150.644);
  var mapOptions = {
    zoom: 12,
    center: latlng
  }
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  codeAddress();
}

function codeAddress() {
  address = "<?php echo $address; ?>";
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
        var populationOptions = {
            strokeColor: '#FF0000',
            strokeOpacity: 0.8,
            strokeWeight: 2,
            fillColor: '#FF0000',
            fillOpacity: 0.35,
            map: map,
            center: results[0].geometry.location,
            radius: 2000
        };
     
      <?php if (($this->memberinfo->rsvp == 1) or ($this->memberinfo->rsvp == 2) or ($this->memberinfo->rsvp == 10) or ($this->memberinfo->rsvp == 3)) : ?>
        var marker = new google.maps.Marker({
            map: map,
            position: results[0].geometry.location
        });
      <?php else: ?>
        cityCircle = new google.maps.Circle(populationOptions);
       
      <?php endif; ?>
       map.setCenter(results[0].geometry.location);
    } 
  });
}

google.maps.event.addDomListener(window, 'load', initialize);

</script>

<div id="panel">
</div>
<div id="map-canvas"></div>

<?php endif; ?>