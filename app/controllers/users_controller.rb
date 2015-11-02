class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user

  def show
    if params[:id].to_i != current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def edit
  end

  def update
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

  def set_user
    @user = current_user
  end
end
