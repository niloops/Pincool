Pincool.Evas =
  draw: (container, is_point_displayed) ->
    container = $(container) if typeof container == "string"

    container.find('ul.evaluation li').each ->
      data_name = $(this).attr("data-name")

      $('<span></span>')
        .addClass("eva_name")
        .text(data_name)
        .attr('title', $(this).attr("data-desc"))
        .appendTo($(this)) if data_name

      $eva_container = $('<span></span>')
        .addClass("eva_container")
        .attr('title', $(this).attr("data-desc"))
        .appendTo($(this))

      width = $eva_container.width() *
        $(this).attr("data-value") /
        $(this).attr("data-max")

      $('<span>&nbsp;</span>')
        .addClass("eva_points eva_points_transition")
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

  ratingReady: (container, callback) ->
    container.find('ul.evaluation li').each (index) ->
      max = +$(this).attr("data-max")
      origin_point = +$(this).attr("data-value")
      $eva_container = $(this).find(".eva_container")

      $eva_display_points = $(this).find(".eva_display_points")
      $eva_display_points.data('display_point', origin_point+'/'+max)
      $eva_points = $eva_container.find(".eva_points")
        .removeClass("eva_points_transition")
      $eva_points.data('point', origin_point)

      max = +$(this).attr("data-max")
      width = $eva_container.width() / max
      i = 0
      $this = $(this)
      while (i < max)
        $("<span></span>")
          .attr('title', i+1)
          .addClass("eva_point")
          .width(width)
          .height($eva_container.height())
          .css('left', i*width)
          .mouseenter ->
            $eva_points.addClass("eva_rating")
            current_point = $(this).attr('title')
            $eva_points.width(current_point*width)
            $eva_display_points.text(current_point+"/"+max)
          .click ->
            $eva_points.removeClass("eva_rating")
            current_point = $(this).attr('title')
            $eva_display_points.data('display_point', current_point+'/'+max)
            $eva_points.data('point', current_point)
            $this.attr('data-value', current_point)
            callback(index, current_point)
          .appendTo($eva_container)
        i++

      $eva_container
        .mouseenter ->
          $eva_points.addClass("eva_rating")
        .mouseleave ->
          $eva_points.removeClass("eva_rating")
          $eva_points.width($eva_points.data('point')*width)
          $eva_display_points.text($eva_display_points.data('display_point'))
