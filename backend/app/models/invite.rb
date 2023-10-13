class Invite < ApplicationRecord
  belongs_to :meeting
  belongs_to :user
  validates :kind, inclusion: { in: 1..3 }
end
