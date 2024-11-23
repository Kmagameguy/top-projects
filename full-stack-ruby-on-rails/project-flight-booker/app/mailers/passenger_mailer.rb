class PassengerMailer < ApplicationMailer
  def thank_you
    @passenger = params[:passenger]
    @booking = params[:booking]
    mail(
      to: email_address_with_name(@passenger.email, @passenger.name),
      subject: 'Thank you for choosing Flight Booker!'
    )
  end
end
