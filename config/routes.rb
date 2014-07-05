Rails.application.routes.draw do

  resources :users

  resources :domains do
      collection do
          post 'update'
          post 'new'
          get 'cartridges'
      end
  end

  root 'domains#index'

end
