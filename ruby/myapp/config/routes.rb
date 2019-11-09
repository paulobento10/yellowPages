Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'users/name/:name', to:'users#showName'
  get 'users/local/:local', to:'users#showLocal'
  get 'users/name/:name/local/:local', to:'users#showNameLocal'
  get 'users/delta/:delta', to:'users#showDelta'
  get 'users/offset/:offset/delta/:delta', to:'users#showOffsetDelta'
  patch 'users/updateCounter/:id', to: 'users#updateCounter'
  patch 'users/editForm/:id', to: 'users#editForm'
end
