json.array!(@places) do |place|
  json.extract! place, :id, :name
  json.url place_url(place, format: :json)
end
