# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users

  get 'welcome/index'
  get '/signup', to: 'users#create'
  post '/signup', to: 'users#create' # with params this time
  get 'users/update', to: 'users#update'
  get 'users/edit', to: 'users#edit' # test requirement
  get 'users/show', to: 'users#show' # test requirement
  match 'users/destroy', to: 'users#destroy', via: [:get, :post] # test requirement
  post 'users/update', to: 'users#update'

  match '/projects?method=create', to: 'projects#create', via: [:get, :post]
  match '/projects?id=*&method=edit', to: 'projects#edit', via: [:get, :post]
  get '/projects/update', to: 'projects#edit'
  post '/projects/update', to: 'projects#update'
  get '/projects/addmem', to: 'projects#addmem'
  post '/projects/addmem', to: 'projects#addmem'

  get '/projmems/index', to: 'projmems#index'

  get '/tasks/index', to: 'tasks#index'
  get '/tasks/create', to: 'tasks#create'
  post '/tasks/create', to: 'tasks#create' # with params this time

  get '/orders/index', to: 'orders#index'

  get '/login', to: 'users#login'
  post '/login', to: 'users#parse_login'

  get 'search/index', to: 'search#index'
  post 'search/index', to: 'search#show'

  get '/wgs/index', to: 'wgs#index'
  get '/wgs/create', to: 'wgs#create'
  post '/wgs/create', to: 'wgs#create' # with params this time
  post '/wgs/destroy', to: 'wgs#destroy'
  get 'wgs/addmem', to: 'wgs#addmem'
  post 'wgs/addmem', to: 'wgs#addmem' # with params this time
  get 'wgs/remmem', to: 'wgs#remmem'
  post 'wgs/remmem', to: 'wgs#remmem'
  get 'wgs/addtsk', to: 'wgs#addtsk'
  post 'wgs/addtsk', to: 'wgs#addtsk' # with params this time
  get 'wgs/remtsk', to: 'wgs#remtsk'
  post 'wgs/remtsk', to: 'wgs#remtsk'

  get 'materials/index', to: 'materials#index'
  get 'materials/addprov', to: 'materials#addprov'
  post 'materials/addprov', to: 'materials#addprov' # with params this time
  get 'materials/remprov', to: 'materials#remprov'
  get 'materials/addof', to: 'materials#addof'
  post 'materials/addof', to: 'materials#addof' # with params this time
  get 'materials/remof', to: 'materials#remof'

  get 'orders/create', to: 'orders#create'
  post 'orders/create', to: 'orders#create' # with params this time
  get 'orders/destroy', to: 'orders#destroy'

  get 'menus/main', to: 'menus#main'

  resources :users, :projects
  root to: 'welcome#index'
end
