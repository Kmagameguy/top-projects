class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: user_to_find)
  end

  private

  def user_to_find
    params[:id] || current_user.id
  end
end
