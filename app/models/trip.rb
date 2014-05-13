class Trip < ActiveRecord::Base
  has_many :ticket_prices
  has_many :tickets, through: :ticket_prices

  validates :name, presence: true
end
