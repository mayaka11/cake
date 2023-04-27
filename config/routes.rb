Rails.application.routes.draw do
  # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

 root to: "public/homes#top"


scope module: :public do

    get '/about' => 'homes#about'
    resources :address, only: [:index, :edit, :create, :update, :destroy]
    get 'orders/completion'
    resources :orders, only: [:new, :create, :index, :show]
    post 'orders/log'
    delete 'cart_items/destroy_all'
    resources :cart_items, only: [:index, :update, :destroy, :create]
    get 'customers/quit'
    patch 'customers/withdrawal'
    resources :customers, only: [:show, :edit, :update]
    resources :items, only: [:index, :show]
  end




namespace :admin do
  get '/' => 'homes#top'
  resources :items, only: [:index, :new, :create, :show, :edit, :update]
  resources :customers, only: [:index, :show, :edit, :update]
  resources :orders, only: [:show, :update]
  resources :order_details, only: [:update]
end
end
