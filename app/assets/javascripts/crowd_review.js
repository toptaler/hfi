var HF = HF || {}
HF.addVoteAjaxListeners = function(selector){
    $(selector).bind('ajax:beforeSend', function(){
        //todo show loading icon in place of upvote icon
    }).bind('ajax:success', function(evt, data, status, xhr){
        //this function is triggered in response to upvote action whether it is triggered from the slider or the main page
        //we must update not just the upvote-count div that was next to to the upvote link that triggered the action
        //but update all upvote-count divs for this campaign id anywhere they might be on the screen
        //this is because if the action is triggered in the slider,
        //when the user exits the slider the upvote count on the home page should have changed to reflect their vote.

        var response = $.parseJSON(xhr.responseText);
        var $link = $(this);
        var campaignId = $link.attr('data-campaign-id');
        var dataCampaignIdSelector = '[data-campaign-id=' + campaignId + ']';
        var upvoteDivz = $('.upvote'+dataCampaignIdSelector);

        for(var i=0; i<upvoteDivz.length; i++){
            var $div = $(upvoteDivz[i]);
            //update count
            var $count = $('.upvote-count', $div).first();
            $count.html(response.votes_count);
            //toggle voted style class
            if($div.hasClass('upvoted'))
                $div.removeClass('upvoted');
            else
                $div.addClass('upvoted');
        }

    }).bind('ajax:error', function(evt, xhr, status, error){
//todo use flash or nicer alerts (sweetalert?)
        var response = $.parseJSON(xhr.responseText);
        alert(response && response.errors? response.errors : error);
    });
}

$(
    function(){
        //Voting
        HF.addVoteAjaxListeners('a.upvote-link[data-remote]');
        //colorbox slider
        $('a.campaign-slider-img-link').colorbox({rel: 'group1', width: '1200px', height: '700px', top: '5%'});
    }
);