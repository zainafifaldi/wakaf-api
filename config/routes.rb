Rails.application.routes.draw do
  resources :banners
  resources :carts
  resources :invoices do
    get 'trx/:transaction_id', action: :show_by_trx, on: :collection
  end
  resources :products do
    resources :images, controller: 'product_images'
  end
  resources :transactions
  resources :transaction_products
  resources :users do
    get 'me', action: :show_me, on: :collection
    patch 'me', action: :update_me, on: :collection
  end

  post 'auth/guest_in', to: 'authentications#guest_in'
  post 'auth/sign_in', to: 'authentications#sign_in'
  post 'auth/register', to: 'authentications#register'
end
