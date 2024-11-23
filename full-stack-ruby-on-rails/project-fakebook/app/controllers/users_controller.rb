class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: user_to_find)
    redirect_to user_posts_path(@user)
  end

  private

  def user_to_find
    params[:id] || current_user.id
  end
end
