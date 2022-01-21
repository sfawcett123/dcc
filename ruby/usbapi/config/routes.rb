# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do

   resources :roles, only: [:show , :index] do
         resources :build, only: [:show, :update], controller: 'role/build'
   end

  get 'arduinos', to: 'arduinos#index'

  get 'usbs', to: 'usbs#index'
  get 'usb/:id/toggle', to: 'usbs#toggle' , as: 'toggle'

  get 'data/:serialnumber/list', to: 'redis#list' , as: 'serialnumber'

  mount Sidekiq::Web => '/sidekiq'

  root to: 'arduinos#index'
end
