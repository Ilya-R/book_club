module BooksHelper
  def show_rating_score(book)
    total_scores = 0
    book.book_user_ratings.all.each { |i| total_scores += i.rating.to_i } unless book.book_user_ratings.all.empty?

    rating = 0
    (rating = total_scores / book.book_user_ratings.all.size) unless book.book_user_ratings.all.empty?
    rating
  end

end

