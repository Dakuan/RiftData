$(document).ready(function () {

    $('#btnResetFilter').click(function () {

        ResetTable();
    });

    $(".confirm").click(function (evt) {
        // Capture link
        var href = $(evt.target).parent().attr('href');

        if (href == undefined) {

            href = $(evt.target).parent().parent().attr('href');
        }

        evt.preventDefault();

        $(this).fastConfirm({
            position: 'left',
            questionText: "Are you sure you want to delete this fish?",
            onProceed: function (trigger) {
                window.location = href;
            }
        });
    });
});

function GenusFilterSelected(data){
    //get all rows
    if (data.value > 0) {
        var rows = $('.tableRow');

        rows.each(function (index) {

            if ($(this).attr('id') != 'TableRow_' + data.value) {

                $(this).fadeOut('slow');
            }
        });
    }
}

function ResetTable() {

    var combobox = $("#GenusBox").data("tComboBox");

    combobox.value(0);

    $('.tableRow').each(function (index) {

        $(this).fadeIn('slow');
    });
}