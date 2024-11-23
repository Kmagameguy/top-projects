class BookingsController < ApplicationController
  def new
    @booking = Flight.find(params[:flight_id]).bookings.new
    params[:num_tickets].to_i.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      flash[:success] = "Flight booked!"
      send_registration_emails
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

  def send_registration_emails
    @booking.passengers.each do |passenger|
      PassengerMailer.with(passenger: passenger, booking: @booking).thank_you.deliver_later
    end
  end
end
