class Passenger
  include Virtus.model
  include ActiveModel::Validations

  attribute :name, String
  attribute :email, String

  validates :name, :email, presence: true
  validates :email, email: true
end
