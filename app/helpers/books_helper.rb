module BooksHelper
  def show_rating_score(book)
    total_scores = 0.0
    book.book_user_ratings.all.each { |i| total_scores += i.rating.to_i } unless book.book_user_ratings.all.empty?

    rating = 0.0

    rating = 0 if book.book_user_ratings.all.empty?

    unless book.book_user_ratings.all.empty?
      (rating = total_scores / book.book_user_ratings.all.size.to_f)
      (rating * 10).to_i.to_f / 10
    end
    rating = 10 if rating == 10.0
    rating
  end

  def book_cover(book)
    if book.cover_picture?
      book.cover_picture.url
    else
      asset_path('book_title.jpg')
    end
  end
end
