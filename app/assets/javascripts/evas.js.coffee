Pincool.Evas = {
  draw: (container, is_point_displayed) ->
    container = $(container) if typeof container == "string"

    container.find('ul.evaluation li').each ->
      data_name = $(this).attr("data-name")

      $('<span></span>')
        .addClass("eva_name")
        .text(data_name)
        .appendTo($(this)) if data_name

      $eva_container = $('<span></span>')
        .addClass("eva_container")
        .attr('title', $(this).attr("data-desc"))
        .appendTo($(this))

      width = $eva_container.width() *
        $(this).attr("data-value") /
        $(this).attr("data-max")

      $('<span>&nbsp;</span>')
        .addClass("eva_points")
        .appendTo($eva_container)
        .data("width", width)
        .width(0)

      $('<span></span>')
        .text($(this).attr("data-value")+'/'+$(this).attr("data-max"))
        .addClass("eva_display_points")
        .appendTo($(this)) if is_point_displayed

    setTimeout(->
      $(".eva_points").each ->
        $(this).css({width: $(this).data("width")})
    , 100)
}
