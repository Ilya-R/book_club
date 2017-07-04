class BookUserRating < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates :rating, :book_id, :user_id, presence: true
  validates :rating, numericality: { message: 'Рейтинг должен быть числовым значением, пожалуйста, не ломайте сайт' }
  validate :rating_in_range?

  def rating_in_range?
    errors.add(:rating, 'Рейтинг должен быть от 1 до 10 включительно') unless (1..10).include?(rating)
  end
end
