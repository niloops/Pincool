Pincool.slideshows = (->
  _current = -1
  ->
    $phases = $('section ul li')
    $imgs = $('figure img')
    _height = $('figure').height()
    _nums = $imgs.length

    _show = ->
      ++_current >= _nums && (_current = 0)
      $imgs.eq(_current).show()
        .css('top', _height)
        .animate({'top': 0}, 800, ->
          setTimeout(Pincool.slideshows, 4000))
      $phases.removeClass('current')
        .eq(_current).addClass('current')
    if _current >= 0
      setTimeout(_show, 200)
      $imgs.eq(_current)
        .animate({top: "-=#{_height}"}, 800)
    else
      _show()
)()
