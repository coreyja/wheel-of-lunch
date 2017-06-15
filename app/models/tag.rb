class Tag < ApplicationRecord
  has_many :restaurant_tags
  has_many :restaurants, through: :restaurant_tags

  scope :with_names, ->(names) { where(name: names) }
end
