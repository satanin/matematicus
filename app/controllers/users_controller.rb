class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])

    result = @user.update_attributes(user_params)

    if result
      redirect_to  user_path(@user), notice: "#{t(:updated, scope: :users)}"
    else
      render :edit
    end

  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
