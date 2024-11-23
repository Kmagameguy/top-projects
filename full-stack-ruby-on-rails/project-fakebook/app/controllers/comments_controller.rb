class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @user = commentable_author

    if @comment.save
      flash[:notice] = "Comment created!"
      redirect_to user_posts_path(@user)
    else
      flash[:alert] = "Couldn't create comment."
      redirect_to user_posts_path(@user), status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @user = commentable_author
    @comment.destroy

    redirect_to user_posts_path(@user), status: :see_other
  end

  private

  def commentable_author
    @comment.commentable.author
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :commentable_id, :commentable_type)
  end
end
