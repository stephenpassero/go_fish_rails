Rails.application.routes.draw do
  resources :game
  post 'game/create'
  get 'game/index'
  get 'game/new'
  get 'game/show'
  get 'game/leave'
  resources :sessions
  root 'sessions#new'
end
