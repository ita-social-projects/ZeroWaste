# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
#   authenticate :user do
#     mount Sidekiq::Web => 'admins/sidekiq'
#   end

  mount Sidekiq::Web => "/sidekiq"

  root 'calculators#index'
  get '/about_us', :to => redirect('/about_us.html')
  devise_for :admins, controllers: { sessions: 'admins/sessions' }

  devise_for :users, controllers: { registrations: 'users/registrations',
                                    omniauth_callbacks:
                                    'users/omniauth_callbacks' }
  resources :calculators, only: %i[index show], param: :slug
  resources :messages, only: %i[new create]


  namespace :admins do
    resources :users, only: %i[index show edit update]
    resources :calculators, param: :slug
    resources :histories, only: :index
    resources :messages, only: %i[index show]

    resources :admins do
      post :update
      get :edit
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
    end
    namespace :v2 do
      resources :calculators, only: [] do
        post :compute, on: :member
      end
    end
  end
end
