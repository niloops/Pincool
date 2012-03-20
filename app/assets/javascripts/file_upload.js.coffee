Pincool.fileUpload = (file_input, dropzone, callback_suc) ->
  $file = $(file_input)
  $dropzone = $(dropzone)
  $file.fileupload({
    dataType: 'json',
    dropZone: $dropzone,
    forceIframeTransport: true,
    formData: ->
      [{name: "policy", value: $file.attr('data-policy')},
        {name: "signature", value: $file.attr('data-signature')}]
  })
  .bind 'fileuploaddragover', ->
    $dropzone.addClass("dragover")
  .bind 'fileuploadsubmit', ->
    $dropzone
      .removeClass()
      .addClass("submitting")
      .find('p').text("您的图片正在上传,请稍候...")
      .end()
      .find('img').remove()
  .bind 'fileuploadfail', (e, data) ->
    $dropzone.removeClass()
      .addClass("fail")
      .find('p').text("对不起，网络通讯中断，请稍后再试")
  .bind 'fileuploaddone', (e, data) ->
    result = data.result
    $dropzone.removeClass()
    $file.val()
    if result.code == "200"
      $dropzone
        .addClass("success")
        .find('p').text('图片上传成功')
      callback_suc(result.url)
    else
      $dropzone
        .addClass("fail")
        .find('p').text("图片上传失败,"+result.message+",请刷新页面重试")

