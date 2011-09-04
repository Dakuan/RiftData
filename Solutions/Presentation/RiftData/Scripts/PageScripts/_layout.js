$(document).ready(function () {
    var hoverAnimationTime = 70;
    $('.headerButton').hover(function () {
        $(this).switchClass('headerButton', 'headerButtonHover', hoverAnimationTime);
    });
    $('.headerButton').mouseout(function () {
        $(this).switchClass('headerButtonHover', 'headerButton', hoverAnimationTime);
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