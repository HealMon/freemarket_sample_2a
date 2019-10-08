class CreditCard < ApplicationRecord
  belongs_to :user

  validates :card_number,                presence: true
  validates :exporation_date,            presence: true
  validates :cvc,                        presence: true
end
