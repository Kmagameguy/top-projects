class SignUpMailer < ApplicationMailer
  default from: 'no-reply@fakebook.com'

  def new_sign_up_email
    @user = params[:user]
    mail(
      to: @user.email,
      subject: 'Welcome to Fakebook!'
    )
  end
end
