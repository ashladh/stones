Rails.application.routes.draw do
  devise_for :users
  namespace :member do
    get "/", to: "pages#dashboard"
  end
  root to: 'pages#index'
end
