module UsersHelper
  def show_nickname
    if user_signed_in?
      if !current_user.nickname.nil?
        current_user.nickname
      elsif !current_user.name.nil?
        current_user.name
      else
        'Профиль'
      end
    else
      'Профиль'
    end
  end

  def show_nickname_comments(comment)
    if comment.user.nickname.present?
      comment.user.nickname
    elsif comment.user.name.present?
      comment.user.name
    else
      'Автор не оставил имени'
    end
  end

  def user_avatar(user)
    if user.avatar?
      user.avatar.url
    else
      asset_path('user_avatar.jpg')
    end
  end

  def count_list_books(user, list_type)
    if user.book_users.where(list_type: list_type).all.any?
      number = user.book_users.where(list_type: list_type).all.size
      word_kind = Russian.p(number, "книгу", "книги", "книг")
      result = ' ' + number.to_s + ' ' + word_kind
      result
    end
  end

  def count_add_books(user)
    if user.books.any?
      number = user.books.size
      word_kind = Russian.p(number, "книгу", "книги", "книг")
      result = number.to_s + ' ' + word_kind
      result
    end
  end

  def count_comment_books(user)
    comments = user.comments.all
    book_ids = []
    comments.each { |comment| book_ids << comment.book_id}
    book_ids.uniq
  end

  def count_discuss_books(user)
    number = count_comment_books(user).size
    word_kind = Russian.p(number, "книгу", "книги", "книг")
    result = ' ' + number.to_s + ' ' + word_kind
    result
  end

  def return_discuss_books(user)
    book_ids = count_comment_books(user)
    books = []
   book_ids.each { |id| books << Book.find(id) }
    books
  end

end
