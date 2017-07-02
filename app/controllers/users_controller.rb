class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # встроенный в девайз фильтр - посылает незалогиненного пользователя
  before_action :authenticate_user!, except: [:show]

  # задаем объект @user для шаблонов и экшенов
  before_action :set_current_user, except: [:show]



  def show
  end

  # GET /users/1/edit
  def edit; end


  # PATCH/PUT /users/1
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

    # Only allow a trusted parameter "white list" through.
    def user_params
      params[:user]
    end
end
