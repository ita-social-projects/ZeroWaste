# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  #   authenticate :user do
  #     mount Sidekiq::Web => 'admins/sidekiq'
  #   end
  mount Sidekiq::Web => "/sidekiq"

  devise_for :users, only: :omniauth_callbacks,
                     controllers: { omniauth_callbacks:
    "users/omniauth_callbacks" }

  get "/", to: "application#redirection", as: :root_redirection

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection
  end

  scope "/(:locale)", locale: /uk|en/ do
    devise_for :users, skip: [:omniauth_callbacks, :registration]

    as :user do
      get :sign_up, to: "users/registrations#new", as: :new_user_registration
      post :sign_up, to: "users/registrations#create", as: :user_registration
    end

    root "home#index"
    get "/sitemap", to: "sitemap#index"

    get "/calculator", to: "calculators#calculator"
    post "/receive_recomendations", to: "calculators#receive_recomendations"

    get "about-us", to: "home#about", as: "about"

    resources :calculators, only: [:index, :show], param: :slug do
      member do
        post :calculate
      end
    end
    resources :messages, only: [:new, :create]
    namespace :account do
      root "dashboard#index"
      resources :users, concerns: :paginatable
      resources :calculators, param: :slug, concerns: :paginatable
      resources :categories, concerns: :paginatable
      resources :products, concerns: :paginatable
      resources :histories, only: :index, concerns: :paginatable
      resources :messages, only: [:index, :show], concerns: :paginatable
      resource :app_config, only: [:edit, :update]
      patch "/feature_flags", to: "feature_flags#update", as: "features_flags"

      resource :site_setting, only: [:edit, :update] do
        put :revert
      end

      scope module: :calculators do
        resources :calculators, only: [], param: :slug do
          resources :fields, only: :new
        end
      end
    end

    namespace :api do
      namespace :v1 do
        resources :calculators, only: [] do
          post :compute, on: :member
        end
        post "/diaper_calculators",
             to: "diaper_calculators#calculate"
      end
      namespace :v2 do
        resources :calculators, only: [] do
          post :compute, on: :member
        end
      end
    end
  end
end
