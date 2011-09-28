
$("#RiftDataPage").live('pagecreate', function () {
    if ($("#Gallery a").length > 0) {
        $("#Gallery a").photoSwipe({ enableMouseWheel: false, enableKeyboard: false });
    }
    $('#SocialMediaButtons').jsShare({ maxwidth: 300, initialdisplay: 'expanded', yoursitename: 'RiftData', desc: 'Rift valley cichlid database', yoursitetitle: 'RiftData', delicious: false, linkedin: false, googlebuzz: false });

    $('<li><div style="margin-top:8px;"><g:plusone size="small" annotation="none"></g:plusone></div></li>').appendTo('#SocialMediaButtons ul');

});

$(document).bind('mobileinit', function () {
    $.mobile.page.prototype.options.addBackBtn = true;
    $.mobile.page.prototype.options.backBtnText = "Back";


});
