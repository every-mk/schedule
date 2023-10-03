class Invite < ApplicationRecord
  belongs_to :meating
  belongs_to :user
  validates :kind, inclusion: { in: 1..3 }
end
