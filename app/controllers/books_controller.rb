class BooksController < ApplicationController
  before_action :set_book, only: [:show]

  before_action :authenticate_user!, except: %i[show index main_page]

  before_action :set_current_user_book, only: %i[edit update]

  def main_page
    @club_choice = set_club_main_book
    @new_clubers = User.last(10)
    @new_books = Book.last(10)
    @top_books = main_rating
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

  def edit; end

  def create
    @book = current_user.books.build(book_params)

    if @book.save
      redirect_to @book, notice: 'Книга была успешно добавлена'
    elsif Book.where(title: @book.title).take.present?
      @book = Book.where(title: @book.title).take
      redirect_to @book, notice: 'Книга уже существует на сайте'
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Книга была отредактирована'
    else
      render :edit, alert: 'Не удалось отредактировать книгу'
    end
  end

  def search
    if params_for_search[:author] == ''
      @result = Book.where(title: params_for_search[:title]).take
    elsif params_for_search[:title] == ''
      @results = Book.where(author: params_for_search[:author]).all
    else
      @result = Book.where(title: params_for_search[:title], author: params_for_search[:author]).all
    end

    render :index

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
      book.book_user_ratings.all.each { |rating| score_array << rating.rating }

      b = 0
      score_array.each { |i| b += i }

      average = 0
      average = b / score_array.size unless score_array.empty?

      score = (book.book_user_ratings.size + book.comments.size) * average

      book_with_scores_hash[book] = score
    end

    max_value = 0
    book_with_scores_hash.each_value { |value| (max_value = value) if value > max_value }

    book_with_scores_hash.index(max_value)
  end

  def params_for_search
    params.permit(:title, :author)
  end

  def main_rating
    books_with_scores = {}
    Book.all.each do |book|
      total_rating = 0
      book.book_user_ratings.all.each {|x| (total_rating += x.rating)}

      total_rating /= book.book_user_ratings.all.size unless book.book_user_ratings.all.empty?
      books_with_scores[book] = total_rating
    end
    ind = 0
    ten_books = {}
    books_with_scores.sort.sort_by { |elem| elem[1] }.reverse.each_with_index do |val,index|
      if index == ind && ind <= 10
        ind += 1
        ten_books[index] = val[0]
      end
    end
    ten_books
  end

  # При большом колличестве книг это позиция выбирается по формуле (голоса+комменты)*средний балл.
  # Если несколько книг имеют одинаковый балл, выбирается та, которая добавлена позже всего.
  # Если и это одинаково, то книга выбирается случайно из набравших высший балл.
  #    В конкурсе учавствуют только книги с обложкой.
  #      Должно считаться раз в месяц.
end
