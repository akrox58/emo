class Mood < ActiveRecord::Base
belongs_to :song
has_many :rater
end
