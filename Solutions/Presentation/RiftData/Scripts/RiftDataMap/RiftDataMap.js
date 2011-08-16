/// <reference path="RiftDataMapService.js" />

var RiftDataMap = function () {

    //extensions
    Microsoft.Maps.Pushpin.prototype.Id = null;
    Microsoft.Maps.Pushpin.prototype.IsLabel = null;

    ///////////////////////////////////////
    //Private fields

    var map;

    var infoBox;

    var service = new RiftDataMapService();

    ///////////////////////////////////////////////////////////
    //Private Methods

    //initialises the map
    function _createMap() {

        var zoomLevel = 7;

        var mapCenter = new Microsoft.Maps.Location(-11.8, 34.58);

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

        _attachEventHandlers();

        _addInfoBox(mapCenter);
    }

    //attches map's event hanglers
    function _attachEventHandlers() {

        Microsoft.Maps.Events.addHandler(map, 'viewchangeend', onViewChangeEnd);

        Microsoft.Maps.Events.addHandler(map, 'viewchangestart', onViewChangeStart);
    }

    //create the infobox in a hidden state
    function _addInfoBox(location) {

        infoBox = new Microsoft.Maps.Infobox(location, { visible: false, zIndex: 999 });

        infoBox.IsLabel = false;

        map.entities.push(infoBox);
    }

    //adds the custom label tile layer, not currently in use!
    function _setLabelTileLayer() {

        var options = { uriConstructor: 'http://localhost:31975/tile/{quadkey}', width: 256, height: 256 };
        var tileSource = new Microsoft.Maps.TileSource(options);
        var tilelayer = new Microsoft.Maps.TileLayer({ mercator: tileSource });
        map.entities.push(tilelayer);
    }

    //adds labels for the current zoom level
    function _addLabelsForZoomLevel() {

        var callback = function (data) {

            //iterate returned DTO's
            $.each(data, function () {

                var text = this.Name;

                var location = new Microsoft.Maps.Location(this.Latitude, this.Longitude);

                //if the locale is visible on the map
                if (map.getBounds().contains(location)) {
                    //show pushpin label
                    _addLabel(location, text);
                    //show infoxboxlabel
                    //_addInfoBoxLabel(location, this.Id);
                }
            });
        };

        service.getLocalesForZoomLevel(map.getZoom(), callback);
    }

    //adds a pushpin label, bit slow, looks shit to boot.
    function _addLabel(location, labelText) {

        var pin = new Microsoft.Maps.Pushpin(new Microsoft.Maps.Location(location.latitude, location.longitude), { text: labelText, icon: '', width: 200, height: 50, zIndex: 500 });

        pin.IsLabel = true;

        map.entities.push(pin);
    }

    //adds an infobox label, seems a bit slow
    function _addInfoBoxLabel(location, localeId) {

        //get html for label
        var url = $('#GetLocaleLabel').attr('value') + '/' + localeId;

        $.get(url, function (markup) {
            var label = new Microsoft.Maps.Infobox(location, { htmlContent: markup });
            label.IsLabel = true;
            map.entities.push(label);
        });
    }

    //removes all labels from the map
    function _clearLabels() {

        var entitiesToRemove = new Array();

        var i = 0;

        for (i = 0; i < map.entities.getLength(); i++) {

            var label = map.entities.get(i);

            if (label.IsLabel) {
                entitiesToRemove.push(label);
            }
        }

        $.each(entitiesToRemove, function () {
            map.entities.pop(this);
        });
    }

    //shows the infobox for given localeID
    function _showInfoBoxForLocale(localeId) {

        var loc;

        var callback = function (localeData) {

            loc = new Microsoft.Maps.Location(localeData.Latitude, localeData.Longitude);

            zoom = _dataZoomLevelToMapZoomLevel(localeData.ZoomLevel);

            var localeInfoBoxCallBack = function (data) {

                infoBox.setLocation(loc);

                infoBox.setOptions({ visible: true, offset: new Microsoft.Maps.Point(-110, 0), htmlContent: data.toString() });

                map.setView({ center: loc, zoom: zoom });
            };

            service.getLocaleInfoBoxContent(localeId, localeInfoBoxCallBack);
        };

        service.getLocaleDto(localeId, callback);
    }

    function _dataZoomLevelToMapZoomLevel(localeZoomLevel) {

        switch (localeZoomLevel) {
            case 1:
                return 8;
            case 2:
                return 9;
            case 3:
                return 11;
            case 4:
                return 12;
            default:
                return 8;
        }
    }

    //adds a species pin to the map
    function _addSpeciesPin(location, Id) {

        var pushpinOptions = { icon: '../../Content/fishPin.png', width: 50, height: 50, zIndex: 999 };

        var pin = new Microsoft.Maps.Pushpin(location, pushpinOptions);

        pin.Id = Id;

        pin.IsLabel = false;

        pushpinClick = Microsoft.Maps.Events.addHandler(pin, 'click', onPushpinClick);

        map.entities.push(pin);
    }

    /////////////////////////////////////////////////////////
    //Event Handlers

    //handles push pin click event
    function onPushpinClick(e) {

        var id = e.target.Id;

        _showInfoBoxForLocale(id);
    }

    //handles conclusion of view change event
    function onViewChangeEnd() {
        _addLabelsForZoomLevel();
    }

    //handles beginning of view change event
    function onViewChangeStart() {
        _clearLabels();
    }

    ////////////////////////////////////////////////////////
    //Public Methods

    //adds fish pics for a species
    this.addPinsForSpecies = function (speciesId) {

        callback = function (data) {

            var locations = new Array();

            //add the new ones
            $(data).each(function () {

                var location = new Microsoft.Maps.Location(this.Latitude, this.Longitude);

                locations.push(location);

                _addSpeciesPin(location, this.Id);
            });

            var locationRect = Microsoft.Maps.LocationRect.fromLocations(locations);

            map.setView({ bounds: locationRect });
        };

        service.getLocalesBySpecies(speciesId, callback);
    }

    //exposes show 
    this.showInfoBoxForLocale = function (localeId) {
        _showInfoBoxForLocale(localeId);
    }

    this.addFishPinAtLocale = function (localeId, speciesId) {

        var callback = function (localeDto) {

            var location = new Microsoft.Maps.Location(localeDto.Latitude, localeDto.Longitude);

            _addSpeciesPin(location, speciesId);
        };

        service.getLocaleDto(localeId, callback);
    }

    //////////////////////////////////////////////////////

    //call initialiser
    _createMap();
};