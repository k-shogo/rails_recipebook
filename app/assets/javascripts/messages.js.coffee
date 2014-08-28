$ ->
  dispatcher = new WebSocketRails(location.host + "/websocket")
  channel = dispatcher.subscribe("messages")
  channel.bind "message", (data) ->
    response = $.parseJSON(data)
    html = response.html
    $('#messages').append html
    p data
