class Permission < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates :privilege, inclusion: { in: 1..3 }
  validates :join, inclusion: { in: [true, false] }
  validates :post, inclusion: { in: [true, false] }
end
