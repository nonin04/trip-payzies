Rails.application.routes.draw do
  devise_for :users

  # 認証状態によるトップページ分岐
  authenticated :user do
    root to: "trips#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "homes#index", as: :unauthenticated_root
  end

  # 立替(個別管理, 複数データ)
  resources :groups do
    collection do
      # 旅行作成時の補助API(選択されたグループidを送信)
      post :members_for_group
    end
  end

  resources :trips do
    # 精算画面・処理
    member do
      get :insights
      get :result
      patch :settle
      patch :unsettle
    end

    # 立替(個別管理, 複数データ)
    resources :expenses, only: [ :show, :new, :create, :edit, :update, :destroy ]
  end

  namespace :share do
    resources :trips, only: [ :show ], param: :share_token do
      member do
        get :insights
        get :result
      end
      resources :expenses, only: [ :show ]
    end
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
