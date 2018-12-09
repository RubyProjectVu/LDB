# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users

  get 'welcome/index'
  get '/signup', to: 'users#create'
  post '/signup', to: 'users#create' # with params wthis time
  get 'users/update', to: 'users#update'
  post 'users/update', to: 'users#update'

  match '/projects?method=create', to: 'projects#create', via: [:get, :post]
  match '/projects?id=*&method=edit', to: 'projects#edit', via: [:get, :post]
  get '/projects/update', to: 'projects#edit'
  post '/projects/update', to: 'projects#update'

  get '/login', to: 'users#login'
  post '/login', to: 'users#parse_login'

  get 'search/index', to: 'search#index'
  post 'search/index', to: 'search#show'

  get 'menus/main', to: 'menus#main'

  resources :users, :projects
  root to: 'welcome#index'
end
