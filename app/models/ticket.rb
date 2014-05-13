class Ticket < ActiveRecord::Base
  belongs_to :ticket_price

  validates :name, :email, presence: true
  validates :email, email: true
end
