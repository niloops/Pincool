Pincool.postForm = ->
  upload_toggle = ->
    $('#change_photo_link,#change_photo_form,
      #imagezone, #dropzone').slideToggle()

  file_upload_ready = ->
    Pincool.fileUpload '#file', '#dropzone', (photo_url) ->
      img_src = $('#file').attr('data-result-url')
      .replace("/stub_path", photo_url)
      $('#dropzone').find('p').text("图片上传成功,读取中...")
      $('#imagezone')
        .empty()
        .prepend("<img src='#{img_src}'>")
        .find('img')
        .load ->
          upload_toggle()
          $('#dropzone')
            .removeClass()
            .find('p').text("请重新上传图片")
      $('#photo').val(photo_url)

  editable_ready = ->
    $('.editable')
      .hover ->
        $(this).toggleClass("inline_edit")
      .click ->
        contents = $.trim($(this).text())
        name = $(this).attr('data-name')
        $(this).hide().next().hide()
        $("##{name}")
          .val(contents)
          .show()
          .focus()
     .each ->
        $(this).trigger('click') unless $.trim($(this).text())


  form_ready = ->
    $("form").submit ->
      if $("#post_photo").val()
        $("#dropzone").addClass("fail").find('p').text("请您上传图片")
        return false

  $('#change_photo_link').click ->
    upload_toggle()
    file_upload_ready()

  editable_ready()
  form_ready()
