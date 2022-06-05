Rails.application.routes.draw do
  devise_for :customers,skip:[:passwords], controllers: {
    registrations:"public/registrations",
    sessions:'public/sessions'
  }

   devise_for :admin,skip:[:registrations,:passwords], controllers: {
    sessions:"admin/sessions"
  }


  root to: "public/homes#top"
  get '/about' => 'public/homes#about', as: 'about'

  get '/customers/my_page/:id' => 'public/customers#show', as: 'customer'
  get '/customers/:id/edit' => 'public/customers#edit' , as: 'edit_customer'
  patch 'customers/:id' => 'public/customers#update' , as: 'update_customer'
  get '/customers/:id/unsubscribe' => 'public/customers#unsubscribe' , as: 'unsubscribe'
  patch '/customers/:id/withdraw' => 'public/customers#withdraw' , as: 'withdraw'

  get 'addresses' => 'public/addresses#index'
  get '/addresses/new'
  post '/addresses' => 'public/addresses#create'
  get '/adresses/:id/edit' => 'public/addresses#edit', as: 'edit_address'
  patch 'addresses/:id' => 'public/addresses#update', as: 'update_address'
  delete 'addresses/:id' => 'public/addresses#destroy', as: 'destroy_address'

  get 'items' => 'public/items#index'
  get 'items/:id' => 'public/items#show', as: 'item'

  get 'cart_items' => 'public/cart_items#index'
  post '/cart_items' => 'public/cart_items#create'
  patch 'cart_items/:id' => 'public/cart_items#update', as: 'update_cart_item'
  delete 'cart_items/:id' => 'public/cart_items#destroy', as: 'destroy_cart_item'
  delete 'cart_items' => 'public/cart_items#destroy_all', as: 'destroy_all_cart_item'

  get '/orders/new' => 'public/orders#new', as: 'new_order'
  post '/orders' => 'public/orders#create'
  post 'order/confirm' => 'public/orders#confirm', as: 'confirm_order'
  get '/orders/thanks' => 'public/orders#thanks' , as: 'thanks_order'
  get 'orders' => 'public/orders#index'
  get 'orders/:id' => 'public/orders#show', as: 'order'

  namespace :admin do
    root to: "homes#top"
    resources :genres, only: [:new, :create, :index, :edit, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show]
  end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
