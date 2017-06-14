FactoryGirl.define do
  factory :tag do
    sequence :name do |i|
      "Tag #{i}"
    end
  end
end
