require 'sidekiq/web'

# frozen_string_literal: true

Rails.application.routes.draw do
  resources :usb
  mount Sidekiq::Web => '/sidekiq'
end
