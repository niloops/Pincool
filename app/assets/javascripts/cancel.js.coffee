Pincool.cancelReady = ->
  $('button[type="cancel"]').click ->
    history.back() && false
