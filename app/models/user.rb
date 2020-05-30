class User < ApplicationRecord
  enum admin: { 無: false, 有: true }
  scope :asc, -> { order(created_at: :asc) }
  before_validation { email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  has_many :tasks, dependent: :destroy
end
