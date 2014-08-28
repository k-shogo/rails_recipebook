$ ->
  $("#messages").on "click", '.message .close', ->
    $(this).closest(".message").fadeOut()
