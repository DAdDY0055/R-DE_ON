Rails.application.routes.draw do

  devise_for :users
  root to: 'spots#index'

  get 'users/show'
  get 'spots/index'
  get 'spots/new'
  get 'spots/show'
  get 'spots/edit'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
end
