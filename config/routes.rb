Rails.application.routes.draw do
  root 'pages#home'
  resources :recipes do
  	member do
  		post 'like'
  	end
  end
  resources :chefs, except: [:new]
  resources :styles, only: [:new, :create, :show]
  resources :ingredients, only: [:new, :create, :show]
  get '/register', to: 'chefs#new'
  get '/login', to: 'logins#new' 
  post '/login', to: 'logins#create'
  get '/logout', to: 'logins#destroy'
end
