Rails.application.routes.draw do


  authenticated :user do
    root 'trips#index', as: :authenticated_root
  end
  unauthenticated do
    root 'homes#index', as: :unauthenticated_root
  end


  resources :trip do

  end


  devise_for :users
  root to: 'homes#top'


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
