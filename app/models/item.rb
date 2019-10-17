class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shipping_charge
  belongs_to_active_hash :estimated_delivery
  belongs_to_active_hash :prefecture

  has_many_attached :images
end