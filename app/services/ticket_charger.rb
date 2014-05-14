class TicketCharger
  include Virtus.model
  include ActiveModel::Validations

  attribute :tickets, [Ticket]
  attribute :token, String
  attribute :charger, Charger

  validates :tickets, :token, presence: true

  def total
    tickets.map(&:price).sum
  end

  def external_charge_id=(id)
    tickets.each do |ticket|
      ticket.external_charge_id = id
      ticket.save!
    end
  end

  def charge!
    charge = charger.purchase!
    self.external_charge_id = charge.id
  end
end
