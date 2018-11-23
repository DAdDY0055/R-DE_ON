Rails.application.routes.draw do

  devise_for :users
  root to: 'spots#index'

  resources :spots
  
  get 'users/show'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
end
