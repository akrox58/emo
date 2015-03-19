class Rater < ActiveRecord::Base
  belongs_to :user
  belongs_to :song
  belongs_to :mood
validates_uniqueness_of :user_id, scope: :song_id
end
