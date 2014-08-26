$ ->
  $('#new_category')
    .on 'ajax:complete', (event, ajax, status) ->
      response = $.parseJSON(ajax.responseText)
      html = response.html
      # 画面に追加
      $('#categories').append html
      # フォームを初期化
      $('#new_category')[0].reset()
