class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_paramters, :only => [:create]

  protected

  def configure_permitted_paramters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
