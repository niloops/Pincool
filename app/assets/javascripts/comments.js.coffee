Pincool.comments =
  createBind: ->
    _comments = this
    $("form.comment_pub").bind 'ajax:success', (e, data, status, xhr) ->
      comment = $(data)
        .hide()
        .insertBefore(this)
        .slideDown()
      _comments.destroyBind(comment.find('.comment_destroy'))
      $(this).find('textarea').val('')
      $(".comments_header span").text ->
        +$(this).text()+1

  destroyBind: ($element)->
    $element.bind 'ajax:success', (e, data, status, xhr) ->
      $(this).parents('article.comment').fadeOut()
      $(".comments_header span").text ->
        +$(this).text()-1

  ready: ->
    this.createBind()
    this.destroyBind($("a.comment_destroy"))
