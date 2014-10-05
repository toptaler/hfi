$ ->
  $('.post').on 'ajax:success', 'a.vote', (event, data, status) ->
    console.log $(this).siblings
    $(this).siblings('span.votes').text(data.total_votes)
