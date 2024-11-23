class User < ApplicationRecord
  before_save { self.email.downcase! }
  after_create :create_profile
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
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one  :profile, dependent: :destroy
end
