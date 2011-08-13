$(document).ready(function () {

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