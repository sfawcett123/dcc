# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do

   resources :roles, only: [ :destroy,  :show , :index] do
         resources :build, only: [:show, :update], controller: 'editrole/build'
   end
   get 'role/create', to: 'roles#create' , as: 'create_role'

   get 'arduinos', to: 'arduinos#index'

   get 'usbs', to: 'usbs#index'
   get 'usb/:id/toggle', to: 'usbs#toggle' , as: 'toggle'

   mount Sidekiq::Web => '/sidekiq'

   root to: 'arduinos#index'
end
