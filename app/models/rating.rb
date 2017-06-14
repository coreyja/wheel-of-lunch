class Rating < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  validates :rating, presence: true, inclusion: (1..5)

  def stars
    rating.times.map { "\u2b50" }.join
  end
end
