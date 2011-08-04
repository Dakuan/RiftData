/// <reference path="../2011.2.712/jquery-1.5.1.min.js" />
var map;

$(window).load(function () {

    CreateMap();

});

function CreateMap() {

    var zoomLevel = 7;

    var loc = new Microsoft.Maps.Location(-11.8, 34.58);

    //create the map
    map = new Microsoft.Maps.Map(document.getElementById("LocaleMap"),
                            {
                                credentials: "AsZr5U9t2cAH1YZh8fMdisYJ3479SF2aw4MqdnC8-cK8bnHS_qpyNeAvXdXg8WID",
                                center: loc,
                                mapTypeId: Microsoft.Maps.MapTypeId.road,
                                zoom: zoomLevel
                            });
}
    
//helper, converts from data zoom levels to map zoom levels
function DataZoomToMapZoom(data) {

    switch (data) {
        case 1:
            return 8;
        case 2:
            return 9;
        case 3:
            return 11;
        case 4:
            return 12;
    }
}

function getTabStrip(){

            var tabStrip = $("#Tabby").data("tTabStrip");
            return tabStrip;
        }

function OnGenusPanelSelect(e) {

     var item = $(e.item);

     var itemInfo = item.find('> .t-link').attr('id').split('_');

     if (itemInfo[0] == 'species') {

         var url = $('#GetLocalesBySpeciesUrl').attr('value') + '/' + itemInfo[1];

         $.get(url, function (data) {

             //clear current pins
             map.entities.clear();

             //add the new ones
             $(data).each(function () {

                var location = new Microsoft.Maps.Location(this.Latitude, this.Longitude);

                 map.entities.push(new Microsoft.Maps.Pushpin(location));
             });
         });
     }
}