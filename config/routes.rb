Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'signin', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  get 'profile', to: 'users#show'
  put 'update_profile', to: 'users#update'

  resources :locations, except: [:destroy, :update]
end
