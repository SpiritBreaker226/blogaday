class CommentsController < ApplicationController
  def index
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post

    if @comment.save
      redirect_to @post, notice: "Comment added"
    else
      flash.now[:alert] = "Unable to added comment"
      render template: "posts/show"
    end
  end

  def update
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(
      :body,
      :post_id,
      :user_id
    )
  end
end
