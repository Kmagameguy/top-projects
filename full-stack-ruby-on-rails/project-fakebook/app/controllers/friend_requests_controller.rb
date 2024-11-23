class FriendRequestsController < ApplicationController
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
    @friend_requests = current_user.friend_requests
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
