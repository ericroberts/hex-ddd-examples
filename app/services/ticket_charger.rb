class TicketCharger
  include Virtus.model
  include ActiveModel::Validations

  attribute :tickets, [Ticket]
  attribute :token, String
  attribute :charger, Charger

  validates :tickets, :token, presence: true

  def charger
    @charger ||= Charger.new(amount: total, token: token)
  end

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
    if charger.purchase!
      self.external_charge_id = charger.charge.id
      true
    else
      false
    end
  end
end
