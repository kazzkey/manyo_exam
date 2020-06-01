class User < ApplicationRecord
  before_validation { email.downcase! }
  before_destroy :check_admin
  before_update :check_no_admin
  has_many :tasks, dependent: :destroy
  scope :asc, -> { order(created_at: :asc) }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  private
  def check_admin
    throw(:abort) if self.admin?
  end
  def check_no_admin
    if User.where(admin: true).length == 1 && self.admin_changed?(from: true, to: false)
      errors.add :base, '【警告】管理者がいなくなってしまいます'
      throw(:abort)
    end
  end
end
