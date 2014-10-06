$(
    function(){
        $('a.upvote-link[data-remote]').bind('ajax:beforeSend', function(){
           //todo show loading icon in place of upvote icon
        }).bind('ajax:success', function(evt, data, status, xhr){
           var response = $.parseJSON(xhr.responseText);
           var $link = $(this);
           var $div = $link.parent('.upvote').first();
           var $count = $link.siblings('.upvote-count').first();
           $count.html(response.votes_count);
           if($div.hasClass('upvoted'))
            $div.removeClass('upvoted');
           else
               $div.addClass('upvoted');
        }).bind('ajax:error', function(evt, xhr, status, error){
//todo use flash or nicer alerts (sweetalert?)
            var response = $.parseJSON(xhr.responseText);
            alert(response && response.errors? response.errors : error);
        });

    }
);