class Flight < ApplicationRecord
  validates :departure_airport_id, presence: true
  validates :arrival_airport_id, presence: true
  validates :departure_time, presence: true

  belongs_to :departure_airport, class_name: 'Airport', primary_key: 'code'
  belongs_to :arrival_airport, class_name: 'Airport', primary_key: 'code'
  has_many :bookings

  scope :upcoming_flight_times, lambda {
    where('departure_time > ?', Time.now)
      .order(departure_time: :asc)
      .map(&:friendly_date)
      .uniq
  }

  def self.search(criteria)
    Flight.where(departure_airport_id: criteria[:departure_airport_id],
                 arrival_airport_id: criteria[:arrival_airport_id])
          .where('num_tickets >= ?', criteria[:num_tickets])
          .select { |f| f.friendly_date == criteria[:departure_time] }
  end

  def friendly_date
    departure_time.strftime('%b %e, %Y')
  end

  def friendly_datetime
    departure_time.strftime('%b %e, %Y at %l:%M %p')
  end
end
