class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books
  has_many :comments
  has_many :book_users
  has_many :book_user_ratings

  mount_uploader :avatar, AvatarUploader
end
