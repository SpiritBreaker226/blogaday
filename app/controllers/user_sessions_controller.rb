class UserSessionsController < ApplicationController
  def new
  	if current_user.present?
  		redirect_back_or_to root_path
  	else
  		@user = User.new
  	end
  end

  def create
  	@user = current_user

  	if @user = login(params[:username], params[:password], params[:remember])
  		redirect_back_or_to root_path, notice: 'Sign in successful'
  	else
  		flash.now.alert = 'Sign in failed'
  		render action: :new
  	end
  end

  def destroy
  	logout
  	redirect_back_or_to root_path, notice: "Signed out!"
  end
end
