class CreditCard < ApplicationRecord
  belongs_to :user

  validates :card_number,                presence: true
  validates :exporation_year,            presence: true
  validates :exporation_month,            presence: true
  validates :cvc,                        presence: true
end
