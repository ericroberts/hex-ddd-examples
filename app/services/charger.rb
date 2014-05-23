class Charger
  include Virtus.model
  include ActiveModel::Validations

  attribute :token, String
  attribute :amount, Money
  attribute :description, String
  attribute :charge, Charge
  attribute :error, Stripe::CardError

  validates :token, :amount, presence: true

  def purchase!
    self.charge = Stripe::Charge.create(
      amount: amount.cents,
      currency: amount.currency.to_s,
      card: token
    )
    true
  rescue Stripe::CardError => e
    self.error = e
    false
  end
end
