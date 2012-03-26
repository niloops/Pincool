Pincool.ajaTab = (content, links)->
  $(links)
    .bind 'ajax:beforeSend', ->
      $(content).empty().addClass("loading_small")
      $(links).removeClass("current")
      $(this).addClass("current")
    .bind 'ajax:success', (e, data, status, xhr) ->
      $(content).removeClass("loading_small")
        .html(data)
  $(links).first().trigger('click')

Pincool.userShow = ->
  Pincool.ajaTab '#users .person_content',
                 '#users .person_head > nav > a'

Pincool.userMessages = ->
  Pincool.ajaTab '#users .messages_content',
                 '#users .messages_head > nav > a'
  $('.message').live 'click', ->
    window.location = $(this).attr('data-url')

Pincool.home = ->
  Pincool.Articles.init()
