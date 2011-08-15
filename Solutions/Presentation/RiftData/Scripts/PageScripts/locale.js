$(window).load(function () {

    var map = new RiftDataMap();

    var localeId = $('#LocaleId').attr('value');

    map.showInfoBoxForLocale(localeId);
});