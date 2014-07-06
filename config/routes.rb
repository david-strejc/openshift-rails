Rails.application.routes.draw do

  resources :users

  resources :domains do
      collection do
          post 'update'
          post 'new'
          post 'create'
          get 'cartridges'
      end
  end

  root 'domains#index'

end
