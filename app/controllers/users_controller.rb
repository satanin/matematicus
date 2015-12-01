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
    redirect_to  user_path(@user), flash[:success]=  "#{t(:updated, scope: :users)}"

    rescue Exception
    render :edit
  end

  def profile
    @profile = User.find_by(username: params[:username])
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end

  def set_user
    @user = current_user
  end

  def wrong_profile?
    params[:id].to_i != current_user.id
  end
end
