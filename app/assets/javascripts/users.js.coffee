Pincool.userShow = ->
  $content_area = $("#users .person_content")
  $links = $('#users .person_head > nav > a')
  $links
    .bind 'ajax:beforeSend', ->
      $content_area.empty().addClass("loading_small")
      $links.removeClass("current")
      $(this).addClass("current")
    .bind 'ajax:success', (e, data, status, xhr) ->
      $content_area.removeClass("loading_small")
        .html(data)
  $links.first().trigger('click')
