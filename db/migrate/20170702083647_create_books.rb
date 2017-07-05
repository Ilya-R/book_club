class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title, null: false, default: 'Название не указано'
      t.string :author, null: false, default: 'Автор не указан'
      t.text :description, null: false, default: 'Описание не добавлено'
      t.string :cover_picture, null: false, default: "/assets/images/book_title.jpg"
      t.references :user, index: true, foreign_key: true
      t.string :genre, null: false, default: 'Жанр не указан'
      t.boolean :best_month, null: false, default: false
      t.datetime :best_month_date

      t.timestamps null: false
    end
  end
end
