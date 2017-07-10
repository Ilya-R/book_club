class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title, null: false, default: 'Название'
      t.string :author, null: false, default: 'Автор'
      t.text :description, null: false, default: 'Описание'
      t.string :cover_picture
      t.references :user, index: true, foreign_key: true
      t.string :genre, null: false, default: 'Жанр'
      t.boolean :best_month, null: false, default: false
      t.datetime :best_month_date

      t.timestamps null: false
    end
  end
end
