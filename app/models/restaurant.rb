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

  def string_tags
    tags.map(&:name).join(' ')
  end

  def string_tags=(string_tags)
    restaurant_tags.where(restaurant: self).destroy_all
    string_tags.split.uniq.each do |tag_name|
      restaurant_tags.build tag: Tag.find_or_create_by!(name: tag_name), restaurant: self
    end
  end
end
