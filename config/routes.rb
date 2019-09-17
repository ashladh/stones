Rails.application.routes.draw do
  devise_for :users
  namespace :member do
    get "/", to: "pages#dashboard"
    get "/calendar", to: "pages#calendar"
    resources :users
  end
  root to: 'pages#index'
end
