var map;

var infoBox;

var mapCenter;

Microsoft.Maps.Pushpin.prototype.Id = null;

function CreateMap() {

    var zoomLevel = 7;

    mapCenter = new Microsoft.Maps.Location(-11.8, 34.58);

    //create the map
    map = new Microsoft.Maps.Map(document.getElementById("LocaleMap"),
    {
        credentials: "AsZr5U9t2cAH1YZh8fMdisYJ3479SF2aw4MqdnC8-cK8bnHS_qpyNeAvXdXg8WID",
        center: mapCenter,
        mapTypeId: Microsoft.Maps.MapTypeId.aerial,
        zoom: zoomLevel
    });
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

function AddPinsForSpecies(speciesId) {

    infoBox = new Microsoft.Maps.Infobox(mapCenter, { title: 'My Pushpin', visible: false });

    var url = $('#GetLocalesBySpeciesUrl').attr('value') + '/' + speciesId;

    $.get(url, function (data) {

        //clear current pins
        map.entities.clear();

        var locations = new Array();

        //add the new ones
        $(data).each(function () {

            var location = new Microsoft.Maps.Location(this.Latitude, this.Longitude);

            locations.push(location);

            var pushpinOptions = { icon: '../../Content/fishPin.png', width: 50, height: 50 };

            var pin = new Microsoft.Maps.Pushpin(location, pushpinOptions);

            pin.Id = this.Id;

            pushpinClick = Microsoft.Maps.Events.addHandler(pin, 'click', onPushpinClick);

            map.entities.push(pin);
        });

        var locationRect = Microsoft.Maps.LocationRect.fromLocations(locations);

        map.setView({ bounds: locationRect });

        map.entities.push(infoBox);
    });
}

function onPushpinClick(e) {
    // do nothing, expect this to be handled by a page script, function included to avoid js error if pushpin click is not required.
}