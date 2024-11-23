class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def set_user
    @user = User.find_by_id(params[:user_id])
    if @user.nil?
      flash[:error] = "User not found"
      redirect_to root_path
    end
  end
end
