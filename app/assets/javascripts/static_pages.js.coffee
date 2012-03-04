Pincool.slideshows = (->
  $imgs = $('figure img')
  $phases = $('section ul li')
  _height = $('figure').height()
  _nums = $imgs.length
  _current = -1
  ->
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

$(window).load(Pincool.slideshows) if $('body').attr('id') == 'static_pages_signup'
