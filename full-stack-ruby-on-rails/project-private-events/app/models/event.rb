class Event < ApplicationRecord
  validates :title, presence: true, length: { maximum: 75 }
  validates :description, presence: true, length: { maximum: 140 }
  validates :location, presence: true
  validates :event_date, presence: true

  belongs_to :creator, class_name: "User"
  has_many :event_attendances, foreign_key: :attended_event_id
  has_many :attendees, through: :event_attendances
end
