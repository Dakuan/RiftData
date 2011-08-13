var map;

var infoBox;

var mapCenter;

Microsoft.Maps.Pushpin.prototype.Id = null;
Microsoft.Maps.Pushpin.prototype.IsLabel = null;

function CreateMap() {

    var zoomLevel = 7;

    mapCenter = new Microsoft.Maps.Location(-11.8, 34.58);

    //create the map
    map = new Microsoft.Maps.Map(document.getElementById("LocaleMap"),
    {
        credentials: "AsZr5U9t2cAH1YZh8fMdisYJ3479SF2aw4MqdnC8-cK8bnHS_qpyNeAvXdXg8WID",
        center: mapCenter,
        mapTypeId: Microsoft.Maps.MapTypeId.aerial,
        zoom: zoomLevel,
        showScalebar: false,
        enableSearchLogo: false,
        enableClickableLogo: false,
        showMapTypeSelector: false,
        labelOverlay: Microsoft.Maps.LabelOverlay.hidden
    });

    Microsoft.Maps.Events.addHandler(map, 'viewchangeend', AddLabelsForZoomLevel);
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

    infoBox = new Microsoft.Maps.Infobox(mapCenter, { visible: false });

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

function AddLabelsForZoomLevel(mapZoomLevel) {

    //clear current labels
    
    //get the locales
    var rah = mapZoomLevel;
}

function ShowInfoBoxForLocale(localeId) {

    var url = $('#LocaleInfoBoxUrl').attr('value') + '/' + localeId;

    $.get(url, function (data) {

        var loc = new Microsoft.Maps.Location(e.target._location.latitude, e.target._location.longitude);

        infoBox.setLocation(loc);

        infoBox.setOptions({ visible: true, offset: new Microsoft.Maps.Point(-110, 0), htmlContent: data.toString() });

        map.setView({ center: loc });
    });
}