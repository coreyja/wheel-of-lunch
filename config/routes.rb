Rails.application.routes.draw do
  get 'welcome', to: 'welcome#index'
  get 'home', to: 'home#index'

  resources :restaurants

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
