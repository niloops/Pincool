Pincool.ajaTab = (content, links)->
  $(links)
    .bind 'ajax:beforeSend', ->
      $(content).empty().addClass("loading_small")
      $(links).removeClass("current")
      $(this).addClass("current")
    .bind 'ajax:success', (e, data, status, xhr) ->
      $(content).removeClass("loading_small")
        .html(data)
  $(links).filter(':first').trigger('click')

Pincool.userShow = ->
  Pincool.ajaTab '#users .person_content',
                 '#users .person_head > nav > a'

Pincool.userMessages = ->
  links = '#users .messages_head > nav > a'
  button = '#users .messages_head > form > button'
  $(links).filter(':first').click ->
    $(button).fadeIn()
  $(links).filter(':last').click ->
    $(button).fadeOut()
  $('.message').live 'click', ->
    window.location = $(this).attr('data-url')
  Pincool.ajaTab '#users .messages_content', links

Pincool.home = ->
  Pincool.Articles.init()
