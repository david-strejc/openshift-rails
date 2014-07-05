Rails.application.routes.draw do

  resources :domains do
      collection do
          post 'update'
          post 'new'
      end
  end

  root 'domains#index'

end
