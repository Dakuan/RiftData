function GenusQuickSearchSelected(data) {

    if (data.value > 0) {

        var url = $('#EditUrl').attr('value') + '/' + data.value;

        $('#QuickSearchEditButton').attr('href', url);

        $('#QuickSearchEditButton').fadeIn();
    }
    else {

        $('#QuickSearchEditButton').fadeOut();
    }
}