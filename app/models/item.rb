class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shipping_charge
  belongs_to_active_hash :shipping_method
  belongs_to_active_hash :estimated_delivery
  belongs_to_active_hash :prefecture

  has_many_attached :images
  
  belongs_to :user
  belongs_to :category

  validates :images, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'] if !Rails.env.test? # テスト環境ではiamgeのvalidation
  validates :name,                    presence: true
  validates :description,             presence: true
  validates :category_id,             presence: true
  validates :condition,               presence: true
  validates :shipping_charge_id,      presence: true
  validates :shipping_method_id,      presence: true
  validates :prefecture_id,           presence: true
  validates :estimated_delivery_id,   presence: true
  validates :trade_status,            presence: true
  validates :price,                   numericality: {greater_than_or_equal_to: 300 , less_than_or_equal_to: 9999999}
end
