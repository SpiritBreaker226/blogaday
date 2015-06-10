class CommentsController < ApplicationController
  before_filter :find_post

  def create
    @comment = Comment.new(comment_params)
    @comments = @post.comments.page(params[:page])
    @comment.user = current_user
    @comment.post = @post

    if @comment.save
      redirect_to @post, notice: "Comment added"
    else
      @markdown_post_body = @post.render_markdown_post_to_html.html_safe

      flash.now[:alert] = "Unable to added comment"
      render template: "posts/show"
    end
  end

  def update
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to @post, notice: "Your comment has been deleted"
  end

  private
  def comment_params
    params.require(:comment).permit(
      :body,
      :post_id,
      :user_id
    )
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
