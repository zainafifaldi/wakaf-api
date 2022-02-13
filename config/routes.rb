Rails.application.routes.draw do
  resources :invoices
  resources :transaction_products
  resources :transactions
  resources :carts
  resources :users
  resources :products do
    resources :images, controller: 'product_images'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post 'auth/sign_in', to: 'authentication#sign_in'
end
