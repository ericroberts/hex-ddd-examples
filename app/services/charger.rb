class Charger
  include Virtus.model
  include ActiveModel::Validations

  attribute :card, String
  attribute :amount, Money
  attribute :description, String
  attribute :charge, Charge

  validates :card, :amount, presence: true

  def purchase!
    Stripe::Charge.create
    self.charge = Charge.new
  end
end

# charge = Stripe::Charge.create(
#       card: token,
#       amount: total.cents,
#       description: "Registration by #{self.full_name} (#{self.email}) for #{self.course.name}",
#       currency: self.course.total.currency
#     )
