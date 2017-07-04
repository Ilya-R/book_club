class Book < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :bookusers

  validates :title, :author, :description, :genre, :user_id, presence: true
  validates :title, length: { maximum: 50 }
  validates :author, length: { maximum: 20 }
  validates :description, length: { maximum: 1000 }
  validates :best_month, inclusion: { in: [true, false] }
  validates :title, :description, uniqueness: true
end


