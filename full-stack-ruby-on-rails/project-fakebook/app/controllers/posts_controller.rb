class PostsController < ApplicationController
  before_action :set_user, only: [:index, :create]

  def index
    @posts = @user.posts
  end

  def create
    @post = current_user.posts.new(body: params[:body])

    if @post.save
      flash[:notice] = "Post created!"
      redirect_to user_posts_path(current_user)
    else
      flash[:alert] = "Couldn't create post."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to user_posts_path(current_user), status: :see_other
  end
end
