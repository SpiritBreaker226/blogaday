class UsersController < ApplicationController
  load_and_authorize_resource except: [:new, :create, :feed]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)

      redirect_to root_path, notice: "Your account has been created"
    else
      flash.now.alert = "Error Creating your account"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user

    if @user.update_attributes(user_params) 
      redirect_to edit_user_path(params[:id]), notice: "Your account has been updated"
    else
      flash.now.alert = "Error Updating your account"
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
  end

  def destroy
  end

  def feed
    @user = User.find(params[:id])
    @posts = @user.posts.display_and_order_by_publish_date

    respond_to do |format|
      format.atom  { render layout: false }
      format.json { render json: @posts }
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :first_name, 
      :last_name, 
      :username, 
      :email, 
      :password,
      :password_confirmation,
      :daily_reminder,
      :enable_daily_reminder
    )
  end
end
