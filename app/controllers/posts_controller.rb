class PostsController < ApplicationController
	def index
		@posts = if params[:search] 
      Post.display_and_order_by_publish_date.where("LOWER(title) LIKE LOWER(?)", "%#{params[:search]}%").page(params[:page])
    else
      Post.display_and_order_by_publish_date.page(params[:page])
    end

    respond_to do |format|
      format.js
      format.html
    end
	end

	def new
		@post = Post.new
    @user = current_user
	end

	def create
		@post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to root_path, notice: "Your post has been created"
    else
      flash.now.alert = "Error Creating your post"
      render :new
    end
	end

	def show
		@post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.page(params[:page])
    @markdown_post_body = @post.render_markdown_post_to_html.html_safe
	end

	def edit
    @post = Post.find(params[:id])
    @user = current_user
  end

  def update
    @post = Post.find(params[:id])
    @post.user = current_user

    if @post.update_attributes(post_params) 
      redirect_to post_path(params[:id]), notice: "Your post has been updated"
    else
      flash.now.alert = "Error Updating your post"
      render :edit
    end
  end

	def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path, notice: "Your post has been deleted"
	end

  private
  def post_params
    params.require(:post).permit(
      :title, 
      :body,
      :summary,
      :publish_date,
      :user_id
    )
  end
end
