Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get '/contact', to: 'static_pages#contact'
  get '/home', to: 'static_pages#home'
  get '/test', to: 'static_pages#test'
  get '/test2', to: 'static_pages#test2'

  root 'static_pages#home'

  resources :users
  resources :projects do
    resources :project_pictures
  end

  resources :pictures, :only => [:create, :edit, :update, :destroy, :show, :index]

  resources :static_pages, :only => [:edit, :update, :show]

  post 'projects/:id/move_image_up' => 'projects#move_image_up', as: :move_project_image_up
  post 'projects/:id/move_image_down' => 'projects#move_image_down', as: :move_project_image_down
  post 'projects/:id/make_thumbnail' => 'projects#make_thumbnail', as: :make_thumbnail
  
  post 'projects/move_project_up' => 'projects#move_project_up', as: :move_project_up
  post 'projects/move_project_down' => 'projects#move_project_down', as: :move_project_down

  get "/sign_up", to: 'users#new'
  post "/sign_up", to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  get '*path' => redirect("/404.html")
end