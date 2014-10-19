//Used by _user_campaign_table.erb
$(function () {
//    $("#user_campaigns").dataTable({paging: false, bInfo: false});

    $('#user_campaigns a.campaign-delete-link[data-remote]').bind('ajax:beforeSend', function(){
        //todo show loading icon in place of upvote icon
    }).bind('ajax:success', function () {
        $(this).closest('tr').fadeOut();
    }).bind('ajax:error', function(evt, xhr, status, error){
        //todo use flash or nicer alerts (sweetalert?)
        var response = $.parseJSON(xhr.responseText);
        alert(response && response.errors? response.errors : error);
    });

});