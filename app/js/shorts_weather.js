$(document).ready(function(){
  setup();
});

function setup() {
  navigator.geolocation.getCurrentPosition(function(position){
    $.ajax({
      url: "/shorts-weather?lat=" + position.coords.latitude + "&long=" + position.coords.longitude,
      type: "get"
    }).done(function(response){
      $(".address").text(response.address);
      if (response.shorts_weather) {
        setShortsWeather();
      } else {
        setNotShortsWeather();
      }
    });
  })
}

function setShortsWeather() {
  $(".answer").addClass("yes");
  $(".answer").html("Yep!");
}

function setNotShortsWeather() {
  $(".answer").addClass("no");
  $(".answer").html("Nope");
}