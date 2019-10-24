Rails.application.routes.draw do

  devise_for :users

  namespace :member do
    get "/", to: "pages#dashboard"
    get :calendar, to: "pages#calendar"
    get :roster, to: "pages#roster"

    resources :users do
      put :stop_acting, on: :collection
      put :act_as, on: :member
    end
    
    resources :characters
    resources :calendar_events do
      get :preview, on: :member
    end

    resources :event_participations
  end

  root to: 'pages#index'

end
