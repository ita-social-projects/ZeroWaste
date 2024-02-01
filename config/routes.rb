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
    get "/about_us", to: redirect("/about_us.html")

    resources :calculators, only: [:index, :show], param: :slug do
      member do
        post :calculate
      end
    end
    resources :messages, only: [:new, :create]
    namespace :account do
      root "dashboard#index"
      resources :users
      resources :calculators, param: :slug
      resources :categories
      resources :products
      resources :histories, only: :index
      resources :messages, only: [:index, :show]
      resource :app_config, only: [:edit, :update]
      patch "/feature_flags", to: "feature_flags#update", as: "features_flags"
      get "/site_setting", to: "site_settings#edit", as: "site_setting"
      resources :diapers_periods, only: [:new, :create, :edit, :destroy]

      resource :site_setting, only: [:edit, :update] do
        resources :diapers_periods, only: [:new, :edit, :update, :create]
        post :revert
        get :show_all_categories, on: :collection
        get :show_diapers_categories, on: :member
        delete :delete_all_periods, on: :collection, to: "site_settings#delete_all_periods", as: "delete_all_periods"
        get "show_diapers_period/:category_id", to: "site_settings#show_diapers_period", as: :show_diapers_period, on: :collection
        get "period/:id/edit", to: "diapers_periods#edit", as: :edit_diapers_period
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
