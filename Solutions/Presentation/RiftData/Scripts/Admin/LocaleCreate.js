var map;
var pin;
var latBox;
var longBox;
var zoomBox;

$(window).load(function () {

    //attach validator
    $("form").validationEngine('attach');

    var successUrl = $('#SuccessUrl').attr('value');

    var failureUrl = $('#FailureUrl').attr('value');

    var window = $("#MessageBox").data("tWindow");

    window.center();

    $('form').submit(function (e) {

        e.preventDefault();

        window.center();

        window.open();

        $.post($(this).attr("action"), $(this).serialize(), function (json) {

            // handle response
            if (json) {

                window.ajaxRequest(successUrl);
            }
            else {

                window.ajaxRequest(failureUrl);
            }

            window.center();
        }, "json");
    });

    //set up lat box reference
    latBox = $("#Latitude").data("tTextBox");

    //set up long box reference
    longBox = $("#Longitude").data("tTextBox");

    zoomBox = $("ZoomLevel").data("tTextBox");

    //if you dont know what is happening here, you are a tit.
    CreateMap();
});

//inits and creates ajax map
function CreateMap() {

    var originalZoomLevel = $('#ZoomLevel').attr('value');

    var zoomLevel = DataZoomToMapZoom(parseInt(originalZoomLevel));
    // Define the pushpin location
    var loc = new Microsoft.Maps.Location(latBox.value(), longBox.value());

    // Add a pin to the map
    pin = new Microsoft.Maps.Pushpin(loc, { draggable: true });

    //wire up drag event
    Microsoft.Maps.Events.addHandler(pin, 'mouseup', OnPushPinChange);

    //create the map
    map = new Microsoft.Maps.Map(document.getElementById("LocaleMap"),
                            {
                                credentials: "AsZr5U9t2cAH1YZh8fMdisYJ3479SF2aw4MqdnC8-cK8bnHS_qpyNeAvXdXg8WID",
                                center: loc,
                                mapTypeId: Microsoft.Maps.MapTypeId.road,
                                zoom: zoomLevel
                            });
    //add the pin
    map.entities.push(pin);
}

//handles lat textbox value change
function OnLatChange(data) {

    var loc = new Microsoft.Maps.Location(data.newValue, longBox.value());

    pin.setLocation(loc);

    map.setView({ center: loc });
}

//handles long textbox value change
function OnLongChange(data) {

    var loc = new Microsoft.Maps.Location(latBox.value(), data.newValue);

    pin.setLocation(loc);

    map.setView({ center: loc });
}

//handles push pin drag event
function OnPushPinChange(data) {

    var location = pin.getLocation();

    latBox.value(location.latitude);

    longBox.value(location.longitude);
}

//handles zoom textbox value change
function OnZoomChange(data) {

    var mapZoomLevel = DataZoomToMapZoom(data.newValue);

    map.setView({ zoom: mapZoomLevel });
}

//helper, converts from data zoom levels to map zoom levels
function DataZoomToMapZoom(data) {

    switch (data) {
        case 1:
            return 8;
        case 2:
            return 9;
        case 3:
            return 11;
        case 4:
            return 12;
    }
}