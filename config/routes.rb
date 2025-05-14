# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  #   authenticate :user do
  #     mount Sidekiq::Web => 'admins/sidekiq'
  #   end
  mount Sidekiq::Web => "/sidekiq"

  devise_for :users, only: :omniauth_callbacks,
                     controllers: { omniauth_callbacks:
                    "users/omniauth_callbacks" }

  get "/", to: "application#redirection", as: :root_redirection

  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection
  end

  scope "/(:locale)", locale: /uk|en/ do
    devise_for :users, only: [:session], skip: [:omniauth_callbacks, :registration]
    # devise_for :users, skip: [:omniauth_callbacks, :registration]

    # as :user do
    #   get :sign_up, to: "users/registrations#new", as: :new_user_registration
    #   post :sign_up, to: "users/registrations#create", as: :user_registration
    # end

    root "home#index"
    get "/sitemap", to: "sitemap#index"

    get "/calculator", to: "calculators#calculator"
    get "/mhc_calculator", to: "calculators#mhc_calculator"
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
      patch "/feature_flags", to: "feature_flags#update", as: "features_flags"

      resource :site_setting, only: [:edit, :update] do
        put :revert
      end

      resources :diapers_periods
      resources :calculators, param: :slug do
        member do
          post :calculate
        end
      end
      namespace :diapers_periods do
        resources :categories, only: [:destroy] do
          get :with_periods, on: :collection
          get :available, on: :collection
        end
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
        post "/pad_calculators",
             to: "pad_calculators#calculate"
      end
      namespace :v2 do
        resources :calculators, only: [:index], param: :slug do
          post :calculate, on: :member
        end
        post "/diaper_calculators",
             to: "diaper_calculators#calculate"
        post "/pad_calculators",
             to: "pad_calculators#calculate"
      end
    end
  end

  match "*path", to: "api/v2/errors#invalid_locale", via: :all, constraints: lambda { |req|
    segments          = req.path.split("/")
    locale            = segments[1]
    prefix            = segments[2..3].join("/")
    available_locales = I18n.available_locales.map(&:to_s)
    locale.present? && available_locales.exclude?(locale) && prefix == "api/v2"
  }, format: false

  get "/404", to: "errors#not_found", as: :not_found_error
  get "/422", to: "errors#unprocessable", as: :unprocessable_error
  get "/500", to: "errors#internal_server", as: :internal_server_error
end
