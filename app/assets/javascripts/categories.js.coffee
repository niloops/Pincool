Pincool.categoriesIndex = ->
  $('.categories_list .category').click ->
    return if $(this).next().is(':visible')
    $('.categories_list').find('.brands_list:visible')
      .slideToggle()
      .prev().removeClass('current')
    $(this).addClass('current')
      .next().stop(true, true).slideToggle()
  .filter(':first').trigger('click')
