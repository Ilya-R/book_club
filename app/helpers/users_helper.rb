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
end
