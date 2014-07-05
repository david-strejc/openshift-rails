Rails.application.routes.draw do

  resources :domains
  root 'domains#index'

end
