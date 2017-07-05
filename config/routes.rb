Rails.application.routes.draw do
  devise_for :users

  root 'books#main_page'

  resources :users, only: %i[show edit update] do
    delete '/book_users/:id', to: 'book_users#destroy'
  end

  resources :books do
    resources :comments, only: %i[create destroy]
    post '/book_user_ratings', to: 'book_user_ratings#create'
    resources :book_users, only: %i[create destroy]
  end
end