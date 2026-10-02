Rails.application.routes.draw do
  concern :searchable do
    get 'by_attr', on: :collection, action: :search_by_attr
  end

  post 'auth/signup', to: 'auth#signup'
  post 'auth/login', to: 'auth#login'
  get 'auth/me', to: 'auth#me'

  resources :stores, only: %i[index show create update destroy], concerns: :searchable
  resources :customers, only: %i[index show create update destroy], concerns: :searchable
  resources :products, only: %i[index show create update destroy], concerns: :searchable
  resources :sellers, only: %i[index show create update destroy], concerns: :searchable
  resources :payments, only: %i[index show create update destroy], concerns: :searchable
  resources :orders, only: %i[index show create update destroy], concerns: :searchable
  resources :order_items, only: %i[index show create update destroy], concerns: :searchable
end
