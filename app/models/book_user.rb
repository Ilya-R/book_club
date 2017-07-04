class BookUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates :list_type, :book_id, :user_id, presence: true
end
