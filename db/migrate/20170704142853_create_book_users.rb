class CreateBookUsers < ActiveRecord::Migration
  def change
    create_table :book_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      t.string :list_type

      t.timestamps null: false
    end
  end
end
