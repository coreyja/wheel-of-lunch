Rails.application.routes.draw do
  get 'welcome', to: 'welcome#index'
  get 'home', to: 'home#index'

  get 'wheel', to: 'restaurant_wheel#index'

  resources :restaurants
  resources :tags

  root 'welcome#index'

  resources :restaurants do
    resources :ratings, only: %i(index new create), controller: 'restaurant_ratings'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
