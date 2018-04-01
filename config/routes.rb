Rails.application.routes.draw do

  devise_for :users

  resources :wikis
  resources :charges, only: [:new, :create]

  post 'downgrade', to: 'charges#downgrade'
  get 'downgrade_to_standard', to: 'charges#downgrade_to_standard'

  get 'welcome/index'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
