
/// <reference path="../2011.2.712/jquery-1.5.1.min.js" />

$(window).load(function () {

    CreateMap();

    //get species id
    var speciesId = $('#SpeciesId').attr('value');

    AddPinsForSpecies(speciesId);

    SetUpPiroBox();
});

function SetUpPiroBox() {
    $().piroBox({
        my_speed: 300, //animation speed
        bg_alpha: 0.5, //background opacity
        slideShow: 'true', // true == slideshow on, false == slideshow off
        slideSpeed: 3 //slideshow 
        //close_all: '.piro_close' // add class .piro_overlay(with comma)if you want overlay click close piroBox
    });
}

function onPushpinClick(e) {

    var id = e.target.Id;

    var url = $('#LocaleInfoBoxUrl').attr('value') + '/' + id;

    $.get(url, function (data) {

        var loc = new Microsoft.Maps.Location(e.target._location.latitude, e.target._location.longitude);

        infoBox.setLocation(loc);

        infoBox.setOptions({ visible: true, offset: new Microsoft.Maps.Point(-110, 0), htmlContent: data.toString() });

        map.setView({ center: loc });
    });
}