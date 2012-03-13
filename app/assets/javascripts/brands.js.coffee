Pincool.brandForm = ->
  Pincool.fileUpload '#file', '#dropzone', (logo_url) ->
    img_src = $('#file').attr('data-result-url')
      .replace("/stub_path", logo_url)
    $('#dropzone').prepend("<img src='#{img_src}'>")
    $('#brand_logo').val(logo_url)
  $("form").submit ->
    unless $("#brand_logo").val()
      $("#dropzone").addClass("fail").find('p').text("请您上传logo图片")
      false

Pincool.followToggle = ->
  $form = $("#follow_toggle")
  $form.bind 'ajax:success', (e, data, status, xhr) =>
    $form.find('button').removeAttr('disabled').replaceWith(data)
    $("#followers_count").text ->
      count = +$(this).text()
      if $form.find('button').hasClass('follow') then count-1 else count+1

Pincool.brandShow = ->
  Pincool.Evas.draw '.brand_head #info'
  Pincool.followToggle()
