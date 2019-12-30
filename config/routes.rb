Rails.application.routes.draw do
  resources :temp_readings
  resources :devices
  get 'home/show'
  root 'home#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
