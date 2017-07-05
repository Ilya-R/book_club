class BooksController < ApplicationController
  before_action :set_book, only: [:show]

  # встроенный в девайз фильтр - посылает незалогиненного пользователя
  before_action :authenticate_user!, except: %i[show index]

  # задаем объект @event от текущего юзера
  before_action :set_current_user_book, only: %i[edit update]

  def index
    @books = Book.all
  end

  def show
    @new_comment = @book.comments.build(params[:comment])
    @book_rating = @book.book_user_ratings.build(params[:book_user_rating])
    @book_list = @book.book_users.build(params[:book_user])
  end

  # GET /books/new
  def new
    @book = current_user.books.build
  end

  def edit;
  end

  def create
    @book = current_user.books.build(book_params)

    if @book.save
      redirect_to @book, notice: 'Книга была успешно добавлена'
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :decription, :cover_picture, :genre)
  end

  def set_current_user_book
    @book = current_user.books.find(params[:id])
  end
end
