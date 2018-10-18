function geolocationSuccesss(position) {
    var longitude = position.coords.longitude;
    var latitude = position.coords.latitude;

    console.log(longitude, latitude);

    $.ajax({
        url: "/restaurants",
        method: "get",
        data: {
            longitude: longitude,
            latitude: latitude
        },
        dataType: 'script'
    });
}

function geolocationError() {
    console.log("Error: geolocation");
}

$(document).on('ready page:load',  function() {

    $('#current-location').click(function(ev) {
        ev.preventDefault();
        if ('geolocation' in navigator ){
            navigator.geolocation.getCurrentPosition(
                geolocationSuccesss, geolocationError);
        } else {
            alert("Browser does not support geolocation");
        }
    });
});



