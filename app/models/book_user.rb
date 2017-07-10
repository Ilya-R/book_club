class BookUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates :list_type, :book_id, :user_id, presence: true
  validates_uniqueness_of :list_type, scope: [:user_id, :book_id]
end
