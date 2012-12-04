$ ->
    $("#src").keyup (e) ->
        me = $("#src")
        val = me.val()
        length = val.length
        $("#len").html(length)
        $.getJSON
        $.post 'http://127.0.0.1:8081/',
            src: me.val(),
            (data) ->
                data
                $("#fp").val data
                $("#sp").val data