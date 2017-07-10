class UsersController < ApplicationController
  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_current_user
    @user = current_user
  end
end
