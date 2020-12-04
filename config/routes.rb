Rails.application.routes.draw do

  devise_for :users
  root 'items#index'

  resources :cards, only: [:new, :show, :destroy, :create] do
    collection do
      post 'pay', to: 'cards#pay'
    end
  end

  resources :users, only: :show do
    resources :favorites, only: [:index]
  end
  
  resources :categories, only: [:index] do
    member do
      get 'parent'
      get 'child'
      get 'grandchild'
    end
  end
  resources :items do
    collection do
      get :search
      get 'get_category_children', defaults: { format: 'json'}
      get 'get_category_grandchildren', defaults: { format: 'json'}
    end
    resources :purchases, only: [:index] do
      collection do
        get 'done', to: 'purchases#done'
        post 'pay', to: 'purchases#pay'
      end
    end
    resource :favorites, only: [:create, :destroy]
    collection do
      get :favorites
    end
  end
  resources :searches,only:[:index]

  get  "searches/detail_search"  => "searches#detail_search"

  resources :comments, only:[:create,:update,:destroy] do
    member do
      get 'restore'
      end
    end

end
