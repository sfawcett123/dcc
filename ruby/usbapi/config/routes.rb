# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  get 'arduinos', action: :list, controller: 'arduinos', format: false
  post 'arduino/read', action: :read, controller: 'arduinos'
  get 'arduino/write', action: :write, controller: 'arduinos'

  get 'usbs', action: :list, controller: 'usbs', format: false

  mount Sidekiq::Web => '/sidekiq'

  # Defines the root path route ("/")
  # root "articles#index"
end
