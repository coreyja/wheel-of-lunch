FactoryGirl.define do
  factory :restaurant do
    sequence :name do |i|
      "Restaurant #{i}"
    end
    walking_minutes_away 6
    street_address '111 Main St'
  end
end
