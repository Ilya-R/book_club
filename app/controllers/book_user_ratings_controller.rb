class BookUserRatingsController < ApplicationController
  before_action :set_book_user_rating, only: [:destroy]
  before_action :set_book, only: %i[create destroy]

  def create

    redirect_to(@book, :alert => 'Сначала нужно отметить оценку') and return if params[:book_user_rating].nil?

    @new_book_user_rating = @book.book_user_ratings.build(book_user_rating_params)
    @new_book_user_rating.user = current_user

    if can_user_rate?(@new_book_user_rating.book_id) && @new_book_user_rating.save


      redirect_to @book, notice: 'Ваша оценка сохранена'

    else
      redirect_to @book, alert: 'Не удалось сохранить вашу оценку, возможно вы уже голосовали!'
    end
  end


  def destroy
    message = {notice: 'Ваша оценка была удалена'}

    if current_user_can_edit?(@book_user_rating)
      @book_user_rating.destroy
    else
      message = {alert: 'Не удалось удалить вашу оценку'}
    end
    redirect_to @book, message
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_book_user_rating
    @book_user_rating = @book.book_users_ratings.find(params[:id])
  end

  def book_user_rating_params
    params.require(:book_user_rating).permit(:rating)
  end
end
