$(function () {
    $('#file').fileupload({
        dataType: 'json',
        url: 'http://v0.api.upyun.com/pincool-photo',
        forceIframeTransport: true,
        formData: function() {
            return $('form').serializeArray();
        },
        progress: function(e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress').text(progress);
        },
        done: function (e, data) {
            url = "http://pincool-photo.b0.upaiyun.com"+data.result.url+"!portrait";
            $('#upyun_result')
            .empty()
            .append('<img src="'+url+'">')
            .append('<h2> code=' + data.result.code + '</h2>' )
            .append('<h3> message=' + data.result.message + '</h3>' );
        }
    });
});
