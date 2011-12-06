/// <reference path="2011.1.315/jquery-1.5.1.min.js" />
var genusSelected = false;
var speciesSelected = false;
var localeSelected = false;

$(document).ready(function () {

    $('.EditPhoto').click(function (e) {

        var photoId = $($(e.currentTarget).children()[0]).attr('value');

        //shove the id into a field
        $('#PhotoBeingEdited').attr('value', photoId);

        //display the caption window thing
        var captionWindow = $("#PhotoCaptionWindow").data("tWindow");

        var captionText = $("#caption_" + photoId).attr('value');

        console.log(captionText);

        $("#Caption").val(captionText);

        captionWindow.center();

        captionWindow.open();
    }); ;

    var successUrl = $('#SuccessUrl').attr('value');

    var failureUrl = $('#FailureUrl').attr('value');

    var window = $("#MessageBox").data("tWindow");

    window.center();

    var photoUploaderWindow = $("#PhotoUploader").data("tWindow");

    photoUploaderWindow.center();

    $('form').submit(function (e) {

        e.preventDefault();

        window.center();

        window.open();

        tinyMCE.triggerSave();

        $.post($(this).attr("action"), $(this).serialize(), function (json) {
            // handle response
            if (json.Success) {

                window.ajaxRequest(successUrl);

            }
            else {

                window.ajaxRequest(failureUrl);

            }

            window.center();

        }, "json");
    });

    $(".confirm").click(function (evt) {
        // Capture link
        var href = $(evt.target).attr("href");

        evt.preventDefault();

        $(this).fastConfirm({
            position: 'left',
            questionText: "Are you sure you want to delete this fish?",
            onProceed: function (trigger) {
                window.location = href;
            }
        });
    });

    $('#btnAddPhoto').click(function () {

        photoUploaderWindow.refresh();

        photoUploaderWindow.open();
    });
});

function OnGenusChange(data) {
    //positive value means its another genus that has been selected
    if (data.value > 0) {

        genusSelected = true;

        CheckIfFormIsValid;

        var speciesBox = $('#Species').data('tDropDownList');

        var url = $('#SpeciesUrl').attr('value');

        url += '/' + data.value;

        var localesUrl = $('#LocalesUrl').attr('value') + '/' + data.value;

        $.getJSON(localesUrl, null, function (localesResult) {

            var localesBox = $('#Locales').data('tDropDownList');

            localesBox.dataBind(localesResult);

            localesBox.select(0);
        });

        $.getJSON(url, null, function (result) {

            speciesBox.dataBind(result);

            speciesBox.select(0);
        });
    }
    else {
        //trigger add genus behaviour
    }
}

function OnSpeciesChange(data) {

    if (data.value > 0) {

        speciesSelected = true;

        CheckIfFormIsValid();
    }
}

function OnLocaleChange(data) {

    if (data.value > 0) {

        localeSelected = true;

        CheckIfFormIsValid();
    }
}

function CheckIfFormIsValid() {

    if (genusSelected && speciesSelected && localeSelected) {

        $('#btnSubmit').fadeIn('slow');
    }
}

function OnSuccess(e) {
    //set image
    if (e.response.status == 'ok') {

        $('#OkButton').fadeIn();

        $('#PreviewImage').attr('src', e.response.url);

        $('#FlickrId').attr('value', e.response.flickrid);

        $('#PhotoId').attr('value', e.response.photoid);
    }
}

//called just before controller action, allows us to add some extra params.
function OnUpload(e) {
    //pass fish id to controller
    e.data = { id: $("#Id").val() };
}