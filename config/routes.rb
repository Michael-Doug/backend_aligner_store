Rails.application.routes.draw do
  #rotas store
  get 'stores/by_attr', to: 'store#search_by_attr'
  get 'stores', to: 'store#index'
  get 'stores/:id', to: 'store#show'
  post 'stores', to: 'store#create'
  put 'stores/:id', to: 'store#update'
  delete 'stores/:id', to: 'store#destroy'
  #rotas customer
  get 'customers/by_attr', to: 'customer#search_by_attr'
  get 'customers', to: 'customer#index'
  get 'customers/:id', to: 'customer#show'
  post 'customers', to: 'customer#create'
  put 'customers/:id', to: 'customer#update'
  delete 'customers/:id', to: 'customer#destroy'
  #rota product
  get 'products/by_attr', to: 'product#search_by_attr'
  get 'products', to: 'product#index'
  get 'products/:id', to: 'product#show'
  post 'products', to: 'product#create'
  put 'products/:id', to: 'product#update'
  delete 'products/:id', to: 'product#destroy'
  #rotas sellers
  get 'sellers/by_attr', to: 'seller#search_by_attr'
  get 'sellers', to: 'seller#index'
  get 'sellers/:id', to: 'seller#show'
  post 'sellers', to: 'seller#create'
  put 'sellers/:id', to: 'seller#update'
  delete 'sellers/:id', to: 'seller#destroy'
  #rotas payments
  get 'payments/by_attr', to: 'payment#search_by_attr'
  get 'payments', to: 'payment#index'
  get 'payments/:id', to: 'payment#show'
  post 'payments', to: 'payment#create'
  put 'payments/:id', to: 'payment#update'
  delete 'payments/:id', to: 'payment#destroy'
  #rotas de orders
  get 'orders/by_attr', to: 'order#search_by_attr'
  get 'orders', to: 'order#index'
  get 'orders/:id', to: 'order#show'
  post 'orders', to: 'order#create'
  put 'orders/:id', to: 'order#update'
  delete 'orders/:id', to: 'order#destroy'
  #Rota dos order_item
  get 'order_items/by_attr', to: 'order_item#search_by_attr'
  get 'order_items', to: 'order_item#index'
  get 'order_items/:id', to: 'order_item#show'
  post 'order_items', to: 'order_item#create'
  put 'order_items/:id', to: 'order_item#update'
  delete 'order_items/:id', to: 'order_item#destroy'
end