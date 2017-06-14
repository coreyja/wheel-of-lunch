FactoryGirl.define do
  factory :user do
    sequence :email do |i|
      "#{i}@example.org"
    end
    password 'SomePassword'
  end
end
