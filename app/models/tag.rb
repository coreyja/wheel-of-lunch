class Tag < ApplicationRecord
  has_many :restaurant_tags
  has_many :restaurants, through: :restaurant_tags

  scope :by_name, -> { order name: :asc }
  scope :with_names, ->(names) { where(name: names.map(&:downcase)) }

  def frequency
    restaurants.count
  end
end
