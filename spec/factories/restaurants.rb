FactoryGirl.define do
  factory :restaurant do
    transient do
      tag_names []
    end
    sequence :name do |i|
      "Restaurant #{i}"
    end
    walking_minutes_away 6
    street_address '111 Main St'

    after(:create) do |restaurant, evaluator|
      tags = evaluator.tag_names.map do |tag_name|
        Tag.find_or_create_by(name: tag_name)
      end
      restaurant.tags << tags
    end
  end
end
