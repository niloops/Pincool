Pincool.Articles =
  container: '#posts',
  url: "",
  page: 1,
  end: false,
  columns_height: [0, 0, 0],
  loading: false,
  goingtotop: false,
  width: 254,
  padding: 20,
  margin: 20

  init: ->
    this.url = $(this.container).attr('data-url')
    this.hangGototop()
    this.bindScroll()
    this.load()

  hangGototop: ->
    $('<aside id="gototop" title="回到顶部"></aside>')
      .insertAfter(this.container)
      .click =>
        this.goingtotop = true
        $('#gototop').fadeOut()
        $('html,body').animate {scrollTop: 0}, 'slow', =>
          this.goingtotop = false

  checkGototop: ->
    return if this.goingtotop
    if $(window).scrollTop() > $(window).height()/2
        $('#gototop').fadeIn() if $('#gototop').is(':hidden')
    else
        $('#gototop').fadeOut() if $('#gototop').is(':visible')

  bindScroll: ->
    $(window).scroll =>
      if $('body')[0].scrollHeight - $(window).height() - $(window).scrollTop() <= 100
        this.load()
      this.checkGototop()

  choiceColumn: ->
    this.columns_height.indexOf(Math.min this.columns_height...)

  addColumnHeight: (column, height) ->
    this.columns_height[column] += height
    $(this.container).height(Math.max this.columns_height...)

  load: ->
    return if this.loading || this.end
    this.loading = true
    $('<div></div>')
      .addClass('posts_loading')
      .appendTo($(this.container))

    $.ajax
      type: "get",
      url: this.url+"?page="+this.page,
      complete: =>
        this.loading = false
        $(this.container).remove('.posts_loading')
      success: (result) =>
        if result.trim() == ""
          return this.end = true
        $(result).filter("article").each (index, article) =>
          $(article).find("section > img").load =>
            this.show article
        this.page++

  show: (article) ->
    column = this.choiceColumn()
    height = this.columns_height[column]
    $(article).css(
      width: this.width
      left: column * (this.margin+this.width+2*this.padding),
      top: height
    )
    .data('column', column)
    .hide()
    .appendTo($(this.container))
    .fadeIn()

    Pincool.Evas.draw $(article)
    this.addColumnHeight(column, $(article).outerHeight() + this.margin)
