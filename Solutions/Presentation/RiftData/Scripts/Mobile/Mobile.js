
$("#RiftDataPage").live('pagecreate', function () {
    if ($("#Gallery a").length > 0) {
        $("#Gallery a").photoSwipe({ enableMouseWheel: false, enableKeyboard: false });
    }
});

$(document).bind('mobileinit', function () {
    $.mobile.page.prototype.options.addBackBtn = true;
    $.mobile.page.prototype.options.backBtnText = "Back";


});
