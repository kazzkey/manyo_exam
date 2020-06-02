class Task < ApplicationRecord
  enum priority: { 低: 0, 中: 1, 高: 2 }
  validates :name, presence: true
  validates :content, presence: true
  scope :desc, -> { order(created_at: :desc) }
  scope :sortby_expired_at, -> { order(expired_at: :desc) }
  scope :sortby_priority, -> { order(priority: :desc) }
  scope :name_like, ->(params) { where("name LIKE ?", "%#{params}%") }
  scope :status, ->(params) { where(status: params) }
  scope :label, ->(params) { joins(:labels).where(labels: {id: params }) }
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  accepts_nested_attributes_for :labellings, allow_destroy: true
end
