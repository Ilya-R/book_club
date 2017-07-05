class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:password, :password_confirmation, :current_password])
  end

  def current_user_can_edit?(model)
    user_signed_in? &&
        (model.user == current_user ||
            (model.try(:book).present? && model.book.user == current_user))
  end

  def can_current_user_rate?(model)
    false if user_signed_in? &&
        (Book_user_rating.where(user: current_user, book: model.book) == model)
  end

  def can_current_user_add?(model)
    false if user_signed_in? &&
        (Book_user.where(user: current_user, book: model.book, list_type: model.list_type) == model)
  end
end
