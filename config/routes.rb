Rails.application.routes.draw do


  devise_for :users
  root 'items#index'
  resources :categories, only: [:index] do
    member do
      get 'parent'
      get 'child'
      get 'grandchild'
    end
  end
  resources :items, except: :show

  #ajax用のルーティングを定義
  resources :items do
    collection do
      get :search

    end
  end

end
