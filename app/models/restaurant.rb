class Restaurant < ApplicationRecord
  has_many :restaurant_tags
  has_many :tags, through: :restaurant_tags
  has_many :ratings

  scope :with_tag_names, ->(tag_names) { joins(:tags).merge(Tag.with_names(tag_names)).uniq }
  scope :without_tag_names, ->(tag_names) { where.not(id: with_tag_names(tag_names)) }

  def average_rating
    if ratings.count.zero?
      0.to_d
    else
      ratings.map(&:rating).map(&:to_d).sum / ratings.count
    end
  end
end
