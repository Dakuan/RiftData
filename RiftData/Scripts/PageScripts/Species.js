$(window).load(function () {

   

    //ExpandPanelBar();

    SetUpPiroBox();


});

function SelectCorrectTab() {

    //get tabstrip
}

function GenusPanelLoad(e) {

    var panel = this.data("tPanelBar");

    var item = $("li:first", panel)[0];

    panel.expand(item);
}

function ExpandPanelBar() {

    //get panel bar
    var panel = $("#GenusPanel_3").data("tPanelBar");

    var item = $("li:first", $("#GenusPanel_3").data("tPanelBar").element)[0]; //DOM element

    $("#GenusPanel_3").data("tPanelBar").expand($("li:first", $("#GenusPanel_3").data("tPanelBar").element)[0]);
}

function SetUpPiroBox() {
    $().piroBox({
        my_speed: 300, //animation speed
        bg_alpha: 0.5, //background opacity
        slideShow: 'true', // true == slideshow on, false == slideshow off
        slideSpeed: 3 //slideshow 
        //close_all: '.piro_close' // add class .piro_overlay(with comma)if you want overlay click close piroBox
    });
}