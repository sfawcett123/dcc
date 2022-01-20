# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do

  namespace :roles do
     get 'list', to: 'list#index'
     patch 'role/:role/edit', to: 'roles#edit'
#     get 'create', to: 'build#create'
#     get 'show', to: 'build#show'
     resources :build
  end

  get 'arduinos', to: 'arduinos#index'

  get 'usbs', to: 'usbs#index'
  get 'usb/:id/toggle', to: 'usbs#toggle' , as: 'toggle'

  get 'data/:serialnumber/list', to: 'redis#list' , as: 'serialnumber'

  mount Sidekiq::Web => '/sidekiq'
end
