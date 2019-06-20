Rails.application.routes.draw do
  post 'games/leave'
  resources :games, only: [ :index, :show, :new, :create ]
  resources :sessions
  root 'sessions#new'
end
