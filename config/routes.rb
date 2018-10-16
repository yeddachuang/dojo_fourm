Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :posts do
    get :feed
  end
  resource :users, only: [:show, :edit, :update]

  namespace :admin do
    resource :categories
    resource :users, only: [:show, :update]
    root "post#index"
  end

  root "posts#index"
end
