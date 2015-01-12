json.array!(@moods) do |mood|
  json.extract! mood, :id, :moodname
  json.url mood_url(mood, format: :json)
end
