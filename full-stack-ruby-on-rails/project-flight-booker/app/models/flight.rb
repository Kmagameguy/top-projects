class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: "Airport", primary_key: "code"
  belongs_to :arrival_airport, class_name: "Airport", primary_key: "code"

  scope :upcoming_flight_times, lambda {
    where("departure_time > ?", Time.now)
      .order(departure_time: :asc)
      .map { |flight| flight.friendly_date }
      .uniq
  }

  def friendly_date
    departure_time.strftime("%b %e, %Y")
  end

  def friendly_datetime
    departure_time.strftime("%b %e, %Y at %l:%M %p")
  end
end
