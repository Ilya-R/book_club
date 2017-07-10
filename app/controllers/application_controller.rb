class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[password password_confirmation current_password])
  end

  def current_user_can_edit?(model)
    user_signed_in? &&
      (model.user == current_user ||
          (model.try(:book).present? && model.book.user == current_user))
  end

  def can_user_rate?(book_id)
    true if user_signed_in? && !current_user.book_user_ratings.where(book_id: book_id).exists?
  end

  def can_current_user_add?(book_user)
    true if user_signed_in? && !current_user.book_users.where(book_id: book_user.book_id, list_type: book_user.list_type).exists?
  end
end
