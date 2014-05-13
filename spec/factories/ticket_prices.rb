FactoryGirl.define do
  factory :ticket_price do
    sequence(:name) { |i| "Ticket Price #{i}" }
    price 100
    association :trip
  end
end
