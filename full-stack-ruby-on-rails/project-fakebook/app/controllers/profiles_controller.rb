class ProfilesController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @profile = @user.profile
  end

  def edit
    @profile = @user.profile
  end

  def update
    @profile = @user.profile

    if @profile.update(profile_params)
      redirect_to user_posts_path(@user), notice: 'Profile was successfully updated.'
    else
      flash[:alert] = @profile.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:email, :phone, :address1, :address2, :city, :state, :zip, :birthday, :bio)
  end
end
