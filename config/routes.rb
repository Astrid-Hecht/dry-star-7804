Rails.application.routes.draw do
  
  resources :doctors, only: [:show, :destroy]
  resources :patients, only: [:index]
end
