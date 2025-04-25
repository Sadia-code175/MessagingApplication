class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :conversations, foreign_key: :sender_id
  has_many :messages
  has_many :notifications, as: :recipient, dependent: :destroy
end