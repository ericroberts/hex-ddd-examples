class TicketPrice < ActiveRecord::Base
  belongs_to :trip
  has_many :tickets

  monetize :price_cents

  validates :name, :price, :trip, presence: true
end
