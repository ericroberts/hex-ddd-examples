class TicketCharger < Struct.new(:tickets, :token)
  include ActiveModel::Validations

  validates :tickets, :token, presence: true
end
