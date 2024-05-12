Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :dashboards, only: %i[show]
  resource :admin do
    resources :users, only: %i[index update destroy]
  end
  resources :books, except: %i[index]
  resources :categories

  root 'dashboards#show'
end
