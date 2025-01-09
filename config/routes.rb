Rails.application.routes.draw do
  devise_for :users
  resources :todo_lists do
    resources :todo_items
  end
  
  # get "home/index"
  root 'home#index'

  get "up" => "rails/health#show", as: :rails_health_check
end
