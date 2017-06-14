class RestaurantTag < ApplicationRecord
  has_one :tag
  has_one :restaurant
end
