Rails.application.routes.draw do

  root 'spots#index'

  devise_for :users

  resources :spots do
    resources :comments
      get :likes, on: :member
  end
    
  resources :users, only: [:show]

  resources :favorites, only: [:create, :destroy]

  resources :about, only: [:index]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
end
