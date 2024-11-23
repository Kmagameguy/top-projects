class LikesController < ApplicationController
  before_action :find_likeable

  def create
    if already_liked?
      flash[:notice] = "You can't like this more than once."
    else
      @likeable.likes.create(user_id: current_user.id)
    end
    redirect_to polymorphic_path([user_path, @likeable])
  end

  def destroy
    Like.where(
      user_id: current_user.id,
      likeable: @likeable
    ).first.destroy
    redirect_to appropriate_redirect
  end

  private

  def appropriate_redirect
    @likeable.is_a?(Post) ? user_posts_path(@likeable.author) : user_posts_path(@likeable.commentable.author)
  end

  def find_likeable
    @likeable = Post.find_by_id(params[:post_id]) if params[:post_id]
    @likeable ||= Comment.find_by_id(params[:comment_id]) if params[:comment_id]
  end

  def already_liked?
    Like.where(
      user_id: current_user.id,
      likeable: @likeable).exists?
  end

  def likeable_user
    @like.likeable.user
  end

  def user_path
    post? ? @likeable.author : @likeable.commentable.author
  end

  def post?
    @likeable.is_a?(Post)
  end
end
