$(document).ready(function () {

    $(".confirm").click(function (evt) {
        // Capture link
        var href = $(evt.target).parent().attr('href');

        if (href == undefined) {

            href = $(evt.target).parent().parent().attr('href');
        }

        evt.preventDefault();

        $(this).fastConfirm({
            position: 'left',
            questionText: "Are you sure you want to delete this genus type?",
            onProceed: function (trigger) {
                window.location = href;
            }
        });
    });
});