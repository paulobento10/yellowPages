Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'users/name/:name', to:'users#showName'
  get 'users/local/:local', to:'users#showLocal'
  get 'users/name/:name/local/:local', to:'users#showNameLocal'
end
