Rails.application.routes.draw do

  get 'arduinos' , action: :list, controller: 'arduinos' , :format => false
  post 'arduino/read' , action: :read, controller: 'arduinos'  
  get 'arduino/write', action: :write, controller: 'arduinos'  

  get 'usbs' , action: :list, controller: 'usbs' ,  :format => false

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
