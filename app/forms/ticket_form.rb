class TicketForm
  include Virtus.model
  include ActiveModel::Validations

  attribute :passengers, [Passenger], default: Passenger.new
  attribute :trip, Trip
  attribute :price, TicketPrice

  validates :trip, :passengers, :price, presence: true
  validate :passengers_are_valid

protected

  def passengers_are_valid
    valid_passengers = passengers.map(&:valid?)
    unless passengers && valid_passengers.all?
      errors.add :passengers, 'must all be valid'
    end
  end
end
