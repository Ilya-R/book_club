class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  # задаем объект @user для шаблонов и экшенов
  before_action :set_current_user, except: [:show]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_user
      @user = current_user
    end

    def user_params
      params[:user]
    end
end
