json.array!(@songs) do |song|
  json.extract! song, :id, :name, :mood_id, :artist_id
  json.url song_url(song, format: :json)
end
