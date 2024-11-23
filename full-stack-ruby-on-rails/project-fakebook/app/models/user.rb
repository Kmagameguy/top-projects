class User < ApplicationRecord
  before_save { self.email.downcase! }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true

  has_many :pending_friends, through: :friend_requests, source: :friend
  has_many :friend_requests, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
end
