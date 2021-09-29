# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :calculators, only: [:show]
  namespace :admins do
    resources :users, only: %i[index show]
    resources :calculators, only: %i[new create edit update]
  end
  namespace :api do
    namespace :v1 do
      resources :calculators, only: [] do
        post :compute, on: :member
      end
    end
  end
  namespace :api do
    namespace :v2 do
      resources :calculators, only: [] do
        post :compute, on: :member
      end
    end
  end
end
