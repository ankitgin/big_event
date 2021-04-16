Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/signup' => 'landing_page#index'
  get '/jobrequest' => 'landing_page#index'
  get '/committee' => 'landing_page#index'
  root 'landing_page#index'
end
