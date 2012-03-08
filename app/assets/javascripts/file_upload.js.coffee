Pincool.fileUpload = (file_input, dropzone) ->
  $file = $(file_input)
  $dropzone = $(dropzone)
  $dropzone.append('<p>您可以直接将图片拖到这里上传:</p>')
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
  .bind 'fileuploaddone', (e, data) ->
    result = data.result
    img_src = $file.attr('data-result-url')
      .replace("/stub_path", result.url)
    $dropzone.removeClass()
    $file.val()
    if result.code == "200"
      $dropzone
        .addClass("success")
        .find('p').text('图片上传成功')
        .before("<img src='#{img_src}'>")
    else
      $dropzone
        .addClass("fail")
        .find('p').text("图片上传失败,"+result.message+",请重试")

