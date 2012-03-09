Pincool.brandForm = ->
  Pincool.fileUpload '#file', '#dropzone', (logo_url) ->
    $('#brand_logo').val(logo_url)
  $("form").submit ->
    unless $("#brand_logo").val()
      $("#dropzone").addClass("fail").find('p').text("请您上传logo图片")
      false

Pincool.brandShow = ->
  Pincool.Evas.draw '.brand_head #info'
