/// <reference path="../RiftDataMap/RiftDataMap.js" />

$(window).load(function () {

    map = new RiftDataMap();

    //get species id
    var localeId = $('#LocaleId').attr('value');

    var speciesId = $('#SpeciesId').attr('value');

    map.showInfoBoxForLocale(localeId);

    map.addFishPinAtLocale(localeId, speciesId);
});