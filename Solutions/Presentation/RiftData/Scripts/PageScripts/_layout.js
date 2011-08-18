$(document).ready(function () {
    var hoverAnimationTime = 100;
    $('.headerButton').hover(function () {
        $(this).switchClass('headerButton', 'headerButtonHover', hoverAnimationTime);
    });
    $('.headerButton').mouseout(function () {
        $(this).switchClass('headerButtonHover', 'headerButton', hoverAnimationTime);
    });
});