class Reccommender < ActiveRecord::Base
  belongs_to :rater
	validates_uniqueness_of :user_id
end
