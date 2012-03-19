Pincool.postPhotos =
  hasAny: ->
    $.trim($('#imagezone').html())

  showChange: ->
    $('#change_photo_form,  #dropzone').slideUp()
    $('#change_photo_link,  #imagezone').slideDown()

  showUpload: ->
    $('#change_photo_form,  #dropzone').slideDown()
    $('#change_photo_link,  #imagezone').slideUp()

  changeReady: ->
    this.showChange()
    $('#change_photo_link').click (e) =>
      e.preventDefault()
      this.uploadReady()

  uploadReady: ->
    this.showUpload()
    Pincool.fileUpload '#file', '#dropzone', (photo_url) =>
      img_src = $('#file').attr('data-result-url')
        .replace("/stub_path", photo_url)
      $('#dropzone').find('p').text("图片上传成功,加载中...")
      $('#imagezone')
        .empty()
        .prepend("<img src='#{img_src}'>")
        .find('img')
        .load =>
          this.changeReady()
          $('#dropzone')
            .removeClass()
            .find('p').text("请重新上传图片")
      $('#photo').val(photo_url)

  ready: ->
    if this.hasAny()
      this.changeReady()
    else
      this.uploadReady()

Pincool.postTexts =
  ready: ->
    $('.inline_edit').each (index, element) =>
      id = $(element).attr("id")
      $show = $("[data-name=\"#{id}\"]")
      return $(element).slideDown() if $show.length == 0
      $show
        .hover ->
          $(this).toggleClass("inline_editing")
        .click ->
          $(this).hide().next().hide()
          $(element)
            .show()
            .focus()

Pincool.postEvas =
  ready: ->
    return if $('#post-evas').length == 0
    Pincool.Evas.draw $('#post-evas'), true, true
    Pincool.Evas.ratingReady $('#post-evas'), (index, point) ->
      evas = $('#evas').val().split(/\s/)
      evas[index] = point.toString()
      $('#evas').val(evas.join(" "))

Pincool.postForm = ->
  Pincool.postPhotos.ready()
  Pincool.postTexts.ready()
  Pincool.postEvas.ready()
  Pincool.cancelReady()
  $("form").submit ->

    if $('#title').length > 0 && !$('#title').val()
      $('#title')
        .after('<span>请您输入标题</span>')
        .next().addClass("error_message")

    unless $("#photo").val()
      $("#dropzone").addClass("fail").find('p').text("请您上传图片")
      return false

Pincool.postShow = ->
  Pincool.Evas.draw $('#post-evas'), true, true

Pincool.postsIndex = ->
  Pincool.Articles.init()
