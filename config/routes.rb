Rails.application.routes.draw do
  devise_for :users

  # 認証状態によるトップページ分岐
  authenticated :user do
    root to: "trips#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "homes#index", as: :unauthenticated_root
  end

  resources :trips do
    # 精算画面・処理
    member do
      get :test
      get :result
      patch :settle
      patch :unsettle
    end

    # 立替(複数,個別管理)
    resources :expenses, only: [ :show, :new, :create, :edit, :update, :destroy ]

    # 参加者(単数,一括管理)
    resource :participants, only: [ :new, :create, :destroy ]
  end


  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unprocessable_entity", via: :all
  match "/500", to: "errors#internal_server_error", via: :all



  # -------------------------------------------------------------------------------------------------
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
