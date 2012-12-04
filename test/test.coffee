$ ->
    $(".front").draggable()
    $(".front").click ->
        console.log(@)
        request = $.get '/'
        request.success (data) -> $('body').append "Successfully got the page again."
        request.error (jqXHR, textStatus, errorThrown) -> $('body').append "AJAX Error: ${textStatus}."