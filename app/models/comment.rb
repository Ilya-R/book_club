class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates :body, :book_id, :user_id, presence: true
  validates :body, length: { maximum: 1000, message: 'Комментарий должен быть меньше 1000 символов' }
  validates :body, uniqueness: { message: 'Нельзя оставлять одинаковые коментарии' }
end

