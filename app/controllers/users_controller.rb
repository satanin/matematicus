class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:show, :edit, :update]
  before_action :set_user

  def show
    redirect_to user_path(current_user.id) if wrong_profile?
  end

  def edit
  end

  def update
    @user.update_attributes!(user_params)
    flash[:success]=  "#{t(:updated, scope: :users)}"
    redirect_to  user_path(@user)

    rescue Exception
    render :edit
  end

  def profile
    @profile = User.find_by(username: params[:username])
  end

  def blacklist
    crypt = ActiveSupport::MessageEncryptor.new(ENV['KEY']) 
    user_email = crypt.decrypt_and_verify(params[:email])
    @user = User.find_by(email: user_email)
    @user.notifications = false
    @user.save
    flash[:success] = "#{t(:disabled, scope: :notifications)}"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :notifications)
  end

  def set_user
    @user = current_user
  end

  def wrong_profile?
    params[:id].to_i != current_user.id
  end
end
