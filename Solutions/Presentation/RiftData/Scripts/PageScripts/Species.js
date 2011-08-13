
/// <reference path="../2011.2.712/jquery-1.5.1.min.js" />

$(window).load(function () {

    CreateMap();

    //get species id
    var speciesId = $('#SpeciesId').attr('value');

    AddPinsForSpecies(speciesId);
});



function onPushpinClick(e) {

    var id = e.target.Id;

    ShowInfoBoxForLocale(id);
}