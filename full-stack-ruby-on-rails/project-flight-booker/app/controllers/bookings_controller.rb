class BookingsController < ApplicationController
  def new
    @booking = Flight.find(params[:flight_id]).bookings.new
    params[:num_tickets].to_i.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      flash[:success] = "Flight booked!"
      redirect_to @booking
    else
      flash[:alert] = "something went wrong"
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, :num_tickets, passengers_attributes: [:id, :name, :email, :booking_id])
  end
end
