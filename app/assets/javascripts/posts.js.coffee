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
  checkEvaluated: ->
    if $('#evaluated_false').attr('checked')
      $('#post-evas').hide()
    $('#evaluated_false').change =>
      $('#post-evas').slideUp()
    $('#evaluated_true').change =>
      $('#post-evas').slideDown()

  evasReady: ->
    Pincool.Evas.draw $('#post-evas'), true, true
    Pincool.Evas.ratingReady $('#post-evas'), (index, point) ->
      evas = $('#evas').val().split(/\s/)
      evas[index] = point.toString()
      $('#evas').val(evas.join(" "))

  ready: ->
    return if $('#post-evas').length == 0
    this.evasReady()
    this.checkEvaluated()

Pincool.postTitle =
  ready: ->
    $('#title').blur =>
      this.check()
  check: ->
    if $('#title').attr('required') && !$('#title').val()
      unless $('#title').next().hasClass("error_message")
        $('#title')
          .after('<span>请您输入标题</span>')
          .next().addClass("error_message")
      return false
    else
      if $('#title').next().hasClass("error_message")
        $('#title').next().remove()
    true

Pincool.postForm = ->
  Pincool.postPhotos.ready()
  Pincool.postTexts.ready()
  Pincool.postEvas.ready()
  Pincool.postTitle.ready()
  Pincool.cancelReady()
  $("form").submit ->
    unless Pincool.postTitle.check()
      $('#title').focus()
      $('html,body').animate {scrollTop: 0}, 'slow'
      return false
    unless $("#photo").val()
      $("#dropzone").addClass("fail").find('p').text("请您上传图片")
      return false
  Pincool.comments.ready()

Pincool.postShow = ->
  Pincool.Evas.draw $('#post-evas'), true, true
  Pincool.comments.ready()

Pincool.postsIndex = ->
  Pincool.Articles.init()
