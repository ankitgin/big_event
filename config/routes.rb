Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #get '/signup' => 'index#index'
  #get '/jobrequest' => 'index#index'
  #get '/committee' => 'index#index'
  #root 'staffs#index'
  root 'landing_page#index'
  resources :jobs, only: [:show, :edit]
  resources :partnership, only: [:show]
  get '/dummy', to: 'partnership#check_user', as: 'check_user'
  get '/status', to: 'job_status#show'
end
