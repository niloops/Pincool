Pincool.comments =
  createBind: ->
    $("form.comment_pub").bind 'ajax:success', (e, data, status, xhr) =>
      $(data)
        .hide()
        .insertAfter("article.comment:last")
        .slideDown()

  destroyBind: ->
    $("a.comment_destroy").bind 'ajax:complete', (e, data, status, xhr) ->
      $(this).parents('article.comment').fadeOut('slow')

  ready: ->
    this.createBind()
    this.destroyBind()
