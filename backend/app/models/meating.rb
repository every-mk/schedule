class Meating < ApplicationRecord
  belongs_to :group
  has_many :invites, dependent: :destroy
  has_many :users, through: :invites
  validates :name, presence: true, length: { maximum: 20 }
  validates :priority, inclusion: { in: 1..3 }
  validates :start_at, comparison: { less_than: :end_at }
  validates :end_at, comparison: { greater_than: :start_at }
  validates :notice_period, inclusion: { in: [true, false] }
  validates :content, presence: true, length: { maximum: 300 }
end
