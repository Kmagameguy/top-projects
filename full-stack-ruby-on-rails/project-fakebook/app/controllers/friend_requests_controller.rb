class FriendRequestsController < ApplicationController
  before_action :set_user, only: [:index]

  def create
    @friend_request = FriendRequest.create(user_id: params[:user_id], friend_id: current_user.id)
    if @friend_request.save
      flash[:notice] = "Friend request sent!"
      redirect_to user_path(params[:user_id])
    else
      flash[:alert] = "Fate laughs at your friend request (an error occurred)"
      redirect_to root_path
    end
  end

  def index
    unless current_user.id == @user.id
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    if @friend_request.destroy
      flash[:notice] = "Friend request cancelled. You two will remain strangers."
      redirect_to user_path(current_user)
    else
      flash[:alert] = "Friend request is too powerful to be cancelled (an error occurred)"
      redirect_to root_path
    end
  end
end
