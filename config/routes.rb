Rails.application.routes.draw do
  resources :sessions
  root 'sessions#new'
end
