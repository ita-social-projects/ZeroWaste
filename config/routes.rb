# frozen_string_literal: true

Rails.application.routes.draw do
  resources :calculators, only: [:show]
  namespace :api do
    namespace :v1 do
      resources :calculators, only: [] do
        post :compute, on: :member
      end
    end
  end
end
