class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, :only => [:create]

  def create
    super do |user|
      if user.persisted?
        SignUpMailer.with(user: user).new_sign_up_email.deliver_later
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
