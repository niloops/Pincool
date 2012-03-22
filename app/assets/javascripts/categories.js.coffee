Pincool.categoriesIndex = ->
  $('.categories_list .category').click ->
    return if $(this).next().is(':visible')
    $('.categories_list').find('.brands_list:visible')
      .slideToggle()
      .prev().removeClass('current')
    $('.categories_list').find('.more:visible').fadeOut()
    $(this).addClass('current')
      .next().stop(true, true).slideToggle()
    $(this).find('.more').fadeIn()
  .filter(':first').trigger('click')
