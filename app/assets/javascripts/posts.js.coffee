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
          contents = $.trim($(this).text())
          $(this).hide().next().hide()
          $(element)
            .val(contents)
            .show()
            .focus()

Pincool.postForm = ->
  Pincool.postPhotos.ready()
  Pincool.postTexts.ready()

