Rails.application.routes.draw do
  resources :invoices
  resources :transaction_products
  resources :transactions
  resources :carts
  resources :product_images
  resources :users
  resources :products
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
