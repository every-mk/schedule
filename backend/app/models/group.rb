class Group < ApplicationRecord
  has_many :permissions, dependent: :destroy
  has_many :meatings, dependent: :destroy
  has_many :users, through: :permissions
  has_many :users, through: :posts
  validates :space, presence: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :content, length: { maximum: 300 }
end
