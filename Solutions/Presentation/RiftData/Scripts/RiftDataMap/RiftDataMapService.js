var RiftDataMapService = function () {

    this.getLocaleInfoBoxContent = function (localeId, callback) {

        var url = $('#LocaleInfoBoxUrl').attr('value') + '/' + localeId;

        $.get(url, callback);
    }

    this.getLocaleDto = function (localeId, callback) {

        var dataUrl = $('#GetLocaleDataUrl').attr('value') + '/' + localeId;

        $.get(dataUrl, callback);
    }

    this.getLocalesForZoomLevel = function (zoomLevel, callback) {

        var url = $('#GetLocalesForZoomLevel').attr('value') + '/' + zoomLevel;

        $.get(url, callback);
    }

    this.getLocalesBySpecies = function (speciesId, callback) {

        var url = $('#GetLocalesBySpeciesUrl').attr('value') + '/' + speciesId;

        $.get(url, callback);
    }
};