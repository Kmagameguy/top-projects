class FriendsController < ApplicationController
  before_action :set_user, only: [:index]

  def create
    @friendship = Friendship.new(friendship_params)
    if @friendship.save
      flash[:notice] = "You are now friends!"
      request = FriendRequest.find_by(friendship_params)
      request.destroy
      redirect_to user_friend_requests_path(friendship_params[:user_id])
    else
      flash[:alert] = "Fate has denied this friendship (an error occurred)"
      redirect_to user_friend_requests_path(friendship_params[:user_id])
    end
  end

  def index
    @friendships = @user.friendships.map { |friendship| User.find(friendship.friend_id) }
  end

  def destroy
    @friendship = Friendship.find_by(params[:user_id])
    if @friendship.destroy
      flash[:notice] = "Friendship ended. 😢"
      redirect_to users_path
    else
      flash[:notice] = "Friendship is too powerful to be ended (an error occurred)"
      redirect_to root_path
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end
