$(document).ready(function () {
    //azure.layoutInit();
    azure.nav.init();
    /*
    azure.portlet.init();
    azure.message.init();
    azure.styleSwitcher();
    azure.layoutSwitcher();
    azure.chart.draw();
    $('#dataTable').tablesorter({ headers: { 4: { sorter: false}} }); 
    $('#gallery a').lightBox(); });*/
    $(".multicollink").click(function(){
            window.location = $(this).attr('href');
        });
});