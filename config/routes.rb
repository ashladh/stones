Rails.application.routes.draw do

  devise_for :users

  namespace :member do
    get "/", to: "pages#dashboard"
    get "/calendar", to: "pages#calendar"
    get "/roster", to: "pages#roster"
    resources :users
    resources :characters
    resources :calendar_events
    resources :event_participations
  end

  root to: 'pages#index'

end
