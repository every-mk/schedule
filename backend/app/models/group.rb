class Group < ApplicationRecord
  validates :space, presence: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :content, length: {maximum: 300 }
end
