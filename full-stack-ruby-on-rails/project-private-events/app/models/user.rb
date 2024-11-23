class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :email, presence: true

  has_many :created_events, foreign_key: :creator_id, class_name: "Event", dependent: :destroy
  has_many :event_attendances, foreign_key: :attendee_id
  has_many :attended_events, through: :event_attendances
end
