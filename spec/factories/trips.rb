FactoryGirl.define do
  factory :trip do
    sequence(:name) { |i| "Trip #{i}" }
  end
end
