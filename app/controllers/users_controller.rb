class UsersController < ApplicationController
  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  def edit
    if user_signed_in?
      @user = current_user
    else
      render :show
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_current_user
    @user = current_user
  end
end
