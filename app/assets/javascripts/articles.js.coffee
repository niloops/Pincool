Pincool.Articles =
  container: '#articles',
  width: 254,
  padding: 20,
  margin: 20

  init: (url) ->
    @url = url || $(@container).attr('data-url')
    @page = 1
    @end = false
    @loading = false
    @goingtotop = false
    @columns_height = [0, 0, 0]
    for height, i in @columns_height
      @columns_height[i] = $(@container).find('> header').outerHeight(true)

    $(@container).find('> article').remove()
    this.bindGototop()
    this.bindScroll()
    this.bindNav()
    this.load()

  bindGototop: ->
    $('#gototop').off().click =>
      @goingtotop = true
      $('#gototop').fadeOut()
      $('html,body').animate {scrollTop: 0}, 'slow', =>
        @goingtotop = false

  checkGototop: ->
    return if @goingtotop
    if $(window).scrollTop() > $(window).height()/2
        $('#gototop').fadeIn() if $('#gototop').is(':hidden')
    else
        $('#gototop').fadeOut() if $('#gototop').is(':visible')

  bindScroll: ->
    $(window).off('scroll.posts').on 'scroll.posts', =>
      if $('body')[0].scrollHeight - $(window).height() - $(window).scrollTop() <= 100
        this.load()
      this.checkGototop()

  bindNav: ->
    _this = this
    $(@container).find('> header nav a').off().click (e) ->
      _this.init $(this).attr('href')
      $(this).parent().children().removeClass('current')
      $(this).addClass('current')
      e.preventDefault()

  load: ->
    return if @loading || @end
    @loading = true
    $('<div></div>')
      .addClass('posts_loading')
      .appendTo($(@container))

    $.ajax
      type: "get",
      url: @url,
      data: {page: @page},
      complete: =>
        @loading = false
        $(@container).find('.posts_loading').remove()
      success: (result) =>
        if result.trim() == ""
          return @end = true
        $(result).filter("article").each (index, article) =>
          $(article).find("section img").load =>
            this.show article
        @page++

  show: (article) ->
    column = @columns_height.indexOf(Math.min @columns_height...)
    height = @columns_height[column]
    $(article).css(
      width: @width
      left: column * (@margin+@width+2*@padding),
      top: height
    )
    .data('column', column)
    .hide()
    .appendTo($(@container))
    .fadeIn()

    Pincool.Evas.draw $(article)
    @columns_height[column] += $(article).outerHeight() + @margin
    $(@container).height(Math.max @columns_height...)
