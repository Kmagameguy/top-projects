class FlightsController < ApplicationController
  def index
    @all_flights = Flight.all

    unless params[:arrival_airport_id].nil?
      @search_results = Flight.where(departure_airport_id: params[:departure_airport_id])
                              .where(arrival_airport_id: params[:arrival_airport_id])
    end
  end

  private

  def flight_params
    params.require(:flight).permit(:departure_airport_id, :arrival_airport_id)
  end
end
