class Event < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :event_date, presence: true

  belongs_to :creator, class_name: "User"
end
