class Group < ApplicationRecord
  has_many :permissions, dependent: :destroy
  has_many :users, through: :permissions
  validates :space, presence: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :content, length: {maximum: 300 }
end
