Pincool.cancelReady = ->
  $('button[type="cancel"]').click ->
    history.back()
    return false
