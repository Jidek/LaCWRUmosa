// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require datetimepicker
//= require_tree .

function populateLocation(event) {
  var original_value = event.target.value;
  navigator.geolocation.getCurrentPosition(
    function(position) { // function on success
      $("#location_latitude").val(position.coords.latitude);
      $("#location_longitude").val(position.coords.longitude);
      event.target.value = original_value;
      event.target.disabled = false;
    },
    function(error) { // function on error
      event.target.value = original_value;
      event.target.disabled = false;
      if (error.code == 1)
        alert("If you don&rsquo;t give us your location, we can&rsquo;t find locations near you!");
      else {
        alert("There was a problem finding your location.");
      }
    }, {maximumAge: 0});
  event.target.value = "Autopopulating location...";
  event.target.disabled = true;
}
