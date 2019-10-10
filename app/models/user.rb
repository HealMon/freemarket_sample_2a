class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :credit_cards , dependent: :destroy


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PASSWORD_VALIDATION = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,128}+\z/i
  validates :nickname,                  presence: true
  validates :email,                     presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :password,                  presence: true, length: {minimum: 7, maximum: 128},    format: { with: PASSWORD_VALIDATION }
  validates :last_name,                 presence: true
  validates :first_name,                presence: true
  validates :last_name_kana,            presence: true
  validates :first_name_kana,           presence: true
  validates :birthday,                  presence: true
  validates :zipcode,                   presence: true
  validates :prefecture_id,             presence: true
  validates :city,                      presence: true
  validates :address,                   presence: true
  validates :delivery_last_name,        presence: true
  validates :delivery_first_name,       presence: true
  validates :delivery_last_name_kana,   presence: true
  validates :delivery_first_name_kana,  presence: true
end
