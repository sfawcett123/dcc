# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  resources :roles
  resources :arduinos
  resources :usbs
  mount Sidekiq::Web => '/sidekiq'
end
