module BooksHelper
  def show_rating_score(book)
    total_scores = 0
    book.book_user_ratings.each { |i| total_scores += i }
    total_scores / book.book_user_ratings.size
  end
end
