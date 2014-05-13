FactoryGirl.define do
  factory :passenger do
    sequence(:name) { |i| "Passenger #{i}" }
    sequence(:email) { |i| "passenger#{i}@email.com" }
  end
end
