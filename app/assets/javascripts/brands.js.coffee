Pincool.brandForm = ->
  Pincool.fileUpload '#file', '#dropzone', (logo_url) ->
    $('#brand_logo').val(logo_url)

Pincool.brandShow = ->
  Pincool.Evas.draw '.brand_head #info'
