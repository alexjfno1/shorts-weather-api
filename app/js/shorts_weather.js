$(document).ready(function(){
  setup();
});

function setup() {
  $(".search-button").click(function(e) {
    e.preventDefault();
    // Disable and replace button with spinner
    var searchTerm = $(".search-box").val();
    $.ajax({
      url: "/shorts-weather/get-position?address=" + encodeURIComponent(searchTerm),
      type: "get"
    }).done(function(response) {
      checkIfItIsShortsWeather(response.latitude, response.longitude);
    });
  });
  navigator.geolocation.getCurrentPosition(function(position) {
    checkIfItIsShortsWeather(position.coords.latitude, position.coords.longitude);
  })
}

function checkIfItIsShortsWeather(latitude, longitude) {
  $.ajax({
    url: "/shorts-weather?lat=" + latitude + "&long=" + longitude,
    type: "get"
  }).done(function(response){
    $(".search-box").val(response.address);
    $(".search-wrapper").show();
    if (response.is_it_shorts_weather) {
      setShortsWeather();
    } else {
      setNotShortsWeather();
    }
  });
}

function setShortsWeather() {
  clearState();
  $(".answer").addClass("yes");
  $(".answer").html("Yep!");
}

function setNotShortsWeather() {
  clearState();
  $(".answer").addClass("no");
  $(".answer").html("Nope");
}

function clearState() {
  $(".answer").removeClass("yes")
  $(".answer").removeClass("no")
}
