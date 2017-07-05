class BookUserRatingsController < ApplicationController
  before_action :set_book_user_rating, only: [:destroy]
  before_action :set_book, only: [:create, :destroy]

  def create
    @new_book_user_rating = @book.book_user_ratings.build(book_user_rating_params)
    @new_book_user_rating.user = current_user

    if can_current_user_rate?(@book_user_rating) && @new_book_user_rating.save
      redirect_to @book, notice: 'Ваша оценка сохранена'
    else
      render @book, alert: 'Не удалось сохранить вашу оценку, возможно вы уже голосовали'
      #render 'books#show', alert: 'Не удалось сохранить вашу оценку'
    end
  end

  def destroy

    message = { notice: 'Ваша оценка была удалена' }

    if current_user_can_edit?(@book_user_rating)
      @book_user_rating.destroy
    else
      message = { notice: 'Не удалось удалить вашу оценку' }
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
    params.fetch(:book_user_rating, {}).permit(:rating)
  end
end
