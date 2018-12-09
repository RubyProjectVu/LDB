# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users

  get 'welcome/index'
  get '/signup', to: 'users#create'
  post '/signup', to: 'users#parse_signup'
  get '/login', to: 'users#login'
  post '/login', to: 'users#parse_login'
  get 'menus/main', to: 'menus#main'

  resources :users, :projects
  root to: 'welcome#index'
end
