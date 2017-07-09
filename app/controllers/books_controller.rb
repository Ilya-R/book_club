class BooksController < ApplicationController
  before_action :set_book, only: [:show]

  # встроенный в девайз фильтр - посылает незалогиненного пользователя
  before_action :authenticate_user!, except: %i[show index main_page]

  # задаем объект @book от текущего юзера
  before_action :set_current_user_book, only: %i[edit update]

  def main_page
    @club_choice = set_club_main_book
  end

  def index
    @books = Book.all
  end

  def show
    @new_comment = @book.comments.build(params[:comment])
    @book_rating = @book.book_user_ratings.build
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

  def search

  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :description, :cover_picture, :genre)
  end

  def set_current_user_book
    @book = current_user.books.find(params[:id])
  end

  def set_club_main_book

    book_with_scores_hash = {}

    Book.all.each do |book|
      score_array = []
      book.book_user_ratings.all.each {|rating| score_array << rating.rating }

      b = 0
      score_array.each {|i| b += i}

      average = 0
      average = b / score_array.size unless score_array.empty?

      score = (book.book_user_ratings.size + book.comments.size) * average

      book_with_scores_hash[book] = score
    end

    max_value = 0
    book_with_scores_hash.each_value {|value| (max_value = value) if (value > max_value) }

    book_with_scores_hash.index(max_value)
  end

  #При большом колличестве книг это позиция выбирается по формуле (голоса+комменты)*средний балл.
  # Если несколько книг имеют одинаковый балл, выбирается та, которая добавлена позже всего.
  # Если и это одинаково, то книга выбирается случайно из набравших высший балл.
  #    В конкурсе учавствуют только книги с обложкой.
  #      Должно считаться раз в месяц.
end

