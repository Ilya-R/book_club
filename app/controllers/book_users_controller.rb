class BookUsersController < ApplicationController
  before_action :set_book, only: [:create, :destroy]
  before_action :set_book_user, only: [:destroy]

  def create
    @new_book_user = @book.book_users.build(book_user_params)
    @new_book_user.user = current_user

    if @new_book_user.save
      redirect_to @book, notice: 'Книга успешно добавлена в список'
    else
      render @book, alert: 'Не удалось внести книгу в список'
      #render 'books#show', alert: 'Не удалось внести книгу в список'
    end
  end

  def destroy
    message = { notice: 'Книга была успешно удалена из списка' }

    if current_user_can_edit?(@book_user)
      @book_user.destroy
    else
      message = { notice: 'Не удалось удалить книгу из списка' }
    end
    redirect_to current_user, message
  end

  private
  def set_book
    @book = Book.find(params[:book_id])
  end
  def book_user_params
    params.fetch(:book_user, {}).permit(:list_type)
  end

  def set_book_user
    @book_user = @book.book_users.find(params[:id])
  end

end
