# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do

  get 'roles', to: 'roles#index'

  get 'arduinos', to: 'arduinos#index'

  get 'usbs', to: 'usbs#index'

  mount Sidekiq::Web => '/sidekiq'
end
