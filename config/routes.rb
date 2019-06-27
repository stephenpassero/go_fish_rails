Rails.application.routes.draw do
  post 'games/leave'
  post 'games/join'
  resources :games do
    member do
      post :run_round
    end
  end
  resources :sessions
  root 'sessions#new'
end
