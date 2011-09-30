
/// <reference path="../2011.2.712/jquery-1.5.1.min.js" />
/// <reference path="../RiftDataMap/RiftDataMap.js" />

$(window).load(function () {

    map = new RiftDataMap();

    //get species id
    var speciesId = $('#SpeciesId').attr('value');

    map.addPinsForSpecies(speciesId);
});
