Rails.application.routes.draw do

  devise_for :users

  authenticated :user do
    root to: 'trips#index', as: :authenticated_root
  end
  unauthenticated do
    root to: 'homes#index', as: :unauthenticated_root
  end

  resources :trip do
    resources :expense, only: [:show, :new, :create, :edit, :update, :destroy]
    
    resource :participants, only: [] do
      collection do
        get 'new'
        post 'create'
        get 'edit'
        patch 'update'
        delete 'destroy'
      end
    end
  end



  # -------------------------------------------------------------------------------------------------
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

end
