var map;

var infoBox;

var mapCenter;

Microsoft.Maps.Pushpin.prototype.Id = null;
Microsoft.Maps.Pushpin.prototype.IsLabel = false;

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

    //SetLabelTileLayer();

    Microsoft.Maps.Events.addHandler(map, 'viewchangeend', AddLabelsForZoomLevel);

    Microsoft.Maps.Events.addHandler(map, 'viewchangestart', ClearLabels);

    infoBox = new Microsoft.Maps.Infobox(mapCenter, { visible: false, zIndex: 999 });

    map.entities.push(infoBox);
}

function SetLabelTileLayer() {

    var options = { uriConstructor: 'http://localhost:31975/tile/{quadkey}', width: 256, height: 256 };
    var tileSource = new Microsoft.Maps.TileSource(options);
    var tilelayer = new Microsoft.Maps.TileLayer({ mercator: tileSource });
    map.entities.push(tilelayer);  
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

    var url = $('#GetLocalesBySpeciesUrl').attr('value') + '/' + speciesId;

    $.get(url, function (data) {

        //clear current pins
        //map.entities.clear();

        var locations = new Array();

        //add the new ones
        $(data).each(function () {

            var location = new Microsoft.Maps.Location(this.Latitude, this.Longitude);

            locations.push(location);

            var pushpinOptions = { icon: '../../Content/fishPin.png', width: 50, height: 50, zIndex: 999 };

            var pin = new Microsoft.Maps.Pushpin(location, pushpinOptions);

            pin.Id = this.Id;

            pushpinClick = Microsoft.Maps.Events.addHandler(pin, 'click', onPushpinClick);

            map.entities.push(pin);
        });

        var locationRect = Microsoft.Maps.LocationRect.fromLocations(locations);

        map.setView({ bounds: locationRect });
    });
}

function AddLabelsForZoomLevel(mapZoomLevel) {

    //.get new set of labels
    var url = $('#GetLocalesForZoomLevel').attr('value') + '/' + map.getZoom();

    $.get(url, function (data) {
        //add each of them
        //        $.each(data, function () {

        //            var labelLocation = new Microsoft.Maps.Location(this.Latitude, this.Longitude);

        //            AddLabel(labelLocation, this.Name);
        //        });
        $.each(data, function () {
            var url = $('#GetLocaleLabel').attr('value') + '/' + this.Id;

            var lat = this.Latitude;
            var long = this.Longitude;
            $.get(url, function (markup) {

                var label = new Microsoft.Maps.Infobox(new Microsoft.Maps.Location(lat, long), { offset: new Microsoft.Maps.Point(0, 0), htmlContent: markup.toString() });

                map.entities.push(label);
            });
        });
    });
}

function AddLabel(location, labelText) {

    var pin = new Microsoft.Maps.Pushpin(new Microsoft.Maps.Location(location.latitude, location.longitude), { text: labelText, icon: '', width: 200, height: 50, zIndex: 500 });

    pin.IsLabel = true;

    map.entities.push(pin);
}

function ClearLabels() {

    var entitiesToRemove = new Array();

    var i = 0;

    for(i = 0; i < map.entities.getLength(); i++){

        var label = map.entities.get(i);

        if (label.IsLabel) {
            entitiesToRemove.push(label);
        }
    }

    $.each(entitiesToRemove, function(){
        
        map.entities.pop(this);
    });
}

function ShowInfoBoxForLocale(localeId) {

    var url = $('#LocaleInfoBoxUrl').attr('value') + '/' + localeId;

    var dataUrl = $('#GetLocaleDataUrl').attr('value') + '/' + localeId;

    var loc;

    $.get(dataUrl, function (localeData) {

        loc = new Microsoft.Maps.Location(localeData.Latitude, localeData.Longitude);

        $.get(url, function (data) {

            infoBox.setLocation(loc);

            infoBox.setOptions({ visible: true, offset: new Microsoft.Maps.Point(-110, 0), htmlContent: data.toString() });

            map.entities.push(infoBox);

            map.setView({ center: loc });
        });
    });
}