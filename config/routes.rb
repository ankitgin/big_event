Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #get '/signup' => 'index#index'
  #get '/jobrequest' => 'index#index'
  #get '/committee' => 'index#index'
  #root 'staffs#index'
  root 'landing_page#index'
  resources :jobs, only: [:show]
end
