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
end
