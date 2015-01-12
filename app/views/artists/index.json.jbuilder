json.array!(@artists) do |artist|
  json.extract! artist, :id, :artistname
  json.url artist_url(artist, format: :json)
end
