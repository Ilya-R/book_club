class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  # задаем объект @user для шаблонов и экшенов
  before_action :set_current_user, except: [:show]

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Данные пользователя были успешно обновлены'
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
    params.require(:user).permit(:name, :email, :avatar, :nickname, :age)
  end

end

