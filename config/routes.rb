# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :admin do
    mount Sidekiq::Web => 'admins/sidekiq'
  end

  root 'calculators#index'

  devise_for :admins, controllers: { sessions: 'admins/sessions' }

  devise_for :users, controllers: { registrations: 'users/registrations',
                                    omniauth_callbacks:
                                    'users/omniauth_callbacks' }
  resources :calculators, only: %i[index show]
  namespace :admins do
    resources :users, only: %i[index show edit update]
    resources :calculators, only: %i[index show new create edit update]
    resources :admins do
      post :update
      get :edit
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
