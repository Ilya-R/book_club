class CreateBookUserRatings < ActiveRecord::Migration
  def change
    create_table :book_user_ratings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      t.integer :rating

      t.timestamps null: false
    end
  end
end
