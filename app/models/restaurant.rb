class Restaurant < ApplicationRecord
  has_many :restaurant_tags
  has_many :tags, through: :restaurant_tags
  has_many :ratings

  def average_rating
    if ratings.count.zero?
      0.to_d
    else
      ratings.map(&:rating).map(&:to_d).sum / ratings.count
    end
  end
end
