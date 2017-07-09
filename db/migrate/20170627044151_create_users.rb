class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :nickname
      t.integer :age
      t.string :email
      t.string :avatar, null: false, default: 'book_title.jpg'

      t.timestamps null: false
    end
  end
end
