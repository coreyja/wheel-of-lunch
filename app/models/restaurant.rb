class Restaurant < ApplicationRecord
  has_many :restaurant_tags
  has_many :tags, through: :restaurant_tags
  has_many :ratings

  scope :by_name, -> { order name: :asc }
  scope :with_tag_names, ->(tag_names) { joins(:tags).merge(Tag.with_names(tag_names)).uniq }
  scope :without_tag_names, ->(tag_names) { where.not(id: with_tag_names(tag_names)) }

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
    restaurant_tags.destroy_all
    string_tags.split.uniq.each do |tag_name|
      restaurant_tags.build tag: Tag.find_or_create_by!(name: tag_name.downcase), restaurant: self
    end
  end
end
