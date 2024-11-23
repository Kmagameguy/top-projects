class FlightsController < ApplicationController
  def index
    @all_flights = Flight.all
    @departure_times = Flight.upcoming_flight_times

    unless params[:arrival_airport_id].nil?
      @search_results = Flight.search(params)
    end
  end

  private

  def flight_params
    params.require(:flight).permit(:departure_airport_id, :arrival_airport_id, :departure_time, :num_tickets)
  end
end
