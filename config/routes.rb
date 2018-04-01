Rails.application.routes.draw do

  devise_for :users

  resources :wikis
  resources :charges, only: [:new, :create]

  get 'charges/cancel', :as => :cancel_charge
  post 'charges/downgrade', :as => :downgrade_to_standard

  get 'welcome/index'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
