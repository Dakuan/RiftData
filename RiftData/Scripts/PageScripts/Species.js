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

    //get the locale id,

    //get the html for the infobox

    //create infoBox options
    var infoboxOptions = { 
            visible:true,
    };

    //move infoBox
    var loc = new Microsoft.Maps.Location(e.target._location.latitude, e.target._location.longitude);

    infoBox.setLocation(loc);

    //fire up the infobox
    infoBox.setOptions(infoboxOptions);
}