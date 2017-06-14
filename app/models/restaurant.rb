class Restaurant < ApplicationRecord
  has_many :restaurant_tags
  has_many :tags, through: :restaurant_tags
  has_many :ratings
end
