$(window).load(function () {

    CreateMap();

    var localeId = $('#LocaleId').attr('value');

    ShowInfoBoxForLocale(localeId);
});