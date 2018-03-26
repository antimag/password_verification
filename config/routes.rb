Rails.application.routes.draw do
  root to: "employers#index"
  get "employers/:id/forgot_password", to: "employers#forgot_password",  as: :forgot_password
  get 'employers/:id/password_token=:password_token', to: 'employers#verify_password'
  get 'employers/:id/edit_password', to: 'employers#edit_password', as: 'edit_password'
  patch 'employers/:id/update_password', to: 'employers#update_password', as: :update_password
  resources :employers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
