Rails.application.routes.draw do
  post 'game/create'
  get 'game/index'
  get 'game/new'
  get 'game/show'
  resources :sessions
  root 'sessions#new'
end
