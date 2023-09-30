# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :permissions, dependent: :destroy
  has_many :groups, through: :permissions
  has_many :groups, through: :posts
  has_many :invites, dependent: :destroy
  has_many :meatings, through: :invites
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true
end
