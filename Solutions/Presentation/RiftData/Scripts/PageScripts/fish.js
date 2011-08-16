/// <reference path="../RiftDataMap/RiftDataMap.js" />

$(window).load(function () {

    map = new RiftDataMap();

    //get species id
    var localeId = $('#LocaleId').attr('value');

    map.showInfoBoxForLocale(localeId);
});