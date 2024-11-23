class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(allowed_user_params)

    if @user.save
      redirect_to user_path @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(allowed_user_params)
      redirect_to user_path @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def allowed_user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
