FactoryGirl.define do
  factory :ticket do
    sequence(:name) { |i| "Passenger #{i}"}
    sequence(:email) { |i| "email#{i}@email.com" }

    association :ticket_price
  end
end
