Rails.application.routes.draw do

  devise_for :users
  root to: 'spots#index'

  resources :spots do
    member do
      get :likes
    end
  end
    
  resources :users, :only => [:show]

  resources :favorites, only: [:create, :destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
end
