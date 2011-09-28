$(document).ready(function () {
    //initialise socaial media buttons
    $('#SocialMediaButtons').jsShare({ maxwidth: 290, initialdisplay: 'expanded', yoursitename: 'RiftData', desc: 'Rift valley cichlid database', yoursitetitle: 'RiftData', delicious: false, linkedin: false, googlebuzz: false });
    $('<li><div style="margin-top:8px;"><g:plusone size="small" annotation="none"></g:plusone></div></li>').appendTo('#SocialMediaButtons ul');
    
    var hoverAnimationTime = 70;
    $('.headerButton').hover(function () {
        $(this).switchClass('headerButton', 'headerButtonHover', hoverAnimationTime);
    });
    $('.headerButton').mouseout(function () {
        $(this).switchClass('headerButtonHover', 'headerButton', hoverAnimationTime);
    });

    //initialise prettyPhoto
    $("a[rel^='prettyPhoto']").prettyPhoto(
    {
        /*theme: /*'pp_default',  'facebook' /* dark_rounded / light_square / dark_square / facebook */
    });

    //hightlight infobboxbuttons
    var components = document.location.href.split('/');

    if (components[components.length - 2] == 'Info') {
        //we are on an info page
        var button;
        switch (components[components.length - 1]) {
            case 'About':
                button = $('.headerButton:contains("About")');
                break;
            case 'HelpUs':
                button = $('.headerButton:contains("Help us")');
                break;
            default:
                break;
        }
        button.attr('class', 'headerButtonHover');
        button.unbind('hover');
        button.unbind('mouseout');
    }
});