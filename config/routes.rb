Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/signup' => 'jobs#index'
  get '/jobrequest' => 'jobs#index'
  get '/committee' => 'jobs#index'
  root 'jobs#index'
end
