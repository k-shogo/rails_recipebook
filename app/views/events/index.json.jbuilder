json.array!(@events) do |event|
  json.extract! event, :id, :title, :description, :date
  json.url event_url(event, format: :json)
end
