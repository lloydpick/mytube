Rails.application.routes.draw do
  resources :providers
  resources :channels
  resources :videos
  
  post 'signup', to: 'users#create'
  post 'auth/login', to: 'authentication#authenticate'
end