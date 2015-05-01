class UsersController < ApplicationController
  load_and_authorize_resource except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
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
      flash.now alert = "Error Updating your account"
      render :edit
    end
  end

  def show
  end

  def destroy
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
