Rails.application.routes.draw do
  post 'games/leave'
  post 'games/join'
  resources :games
  resources :sessions
  root 'sessions#new'
end
