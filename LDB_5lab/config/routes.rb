# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get 'welcome/index'
  get '/signup', to: 'users#create'
  get '/login', to: 'users#login'
  post '/login', to: 'users#parse_login'

  resources :users
  root 'welcome#index'
end
