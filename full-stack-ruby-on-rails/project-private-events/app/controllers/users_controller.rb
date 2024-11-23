class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])

    if current_user.id != @user.id
      flash[:alert] = 'Access denied.'
      redirect_to root_path
    end
  end
end
