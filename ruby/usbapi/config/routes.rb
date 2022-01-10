# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  get 'arduinos', action: :list, controller: 'arduinos', format: false

  get 'arduino/read', action: :read, controller: 'arduinos'
  patch 'arduino/:serialnumber', action: :update, controller: 'arduinos'

  get 'usbs', action: :list, controller: 'usbs', format: false

  get 'roles', action: :list, controller: 'roles', format: false

  mount Sidekiq::Web => '/sidekiq'

end
