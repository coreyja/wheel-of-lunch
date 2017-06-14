class RestaurantTag < ApplicationRecord
  belongs_to :tag
  belongs_to :restaurant
end
