Rails.application.routes.draw do
  resources :users do
    collection do
      get :login
    end
  end

  namespace :public do
    post '/users/login', to: 'users#login'
  end

  namespace :private do
    post '/users/verify_email', to: 'users#verify_email'
  end

  root to: 'users#index'
end
