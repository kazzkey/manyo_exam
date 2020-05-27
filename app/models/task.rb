class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  scope :desc, -> { order(created_at: :desc) }
  scope :sortby_expired_at, -> { order(expired_at: :desc) }
  scope :name_like, ->(params) { where("name LIKE ?", "%#{params}%") }
  scope :status, ->(params) { where(status: params) }
  scope :search_all, ->(name, status) { name_like.status }
end
