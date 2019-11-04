Rails.application.routes.draw do
  
  devise_for :users, skip: :all
  devise_scope :user do
    get 'signup' => 'devise/registrations#index', as: :new_user_information
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_registration
    delete 'logout' => 'devise/sessions#destroy', as: :user_logout
  end

  resources :signup do
    collection do
      get 'registration/' => 'signup#new'
      get 'sms_confirmation/' => 'signup#phone1'
      get 'sms_confirmation/sms' => 'signup#phone2'
      get 'address' => 'signup#address'
      get 'credit_card' => 'signup#payment'
      get 'user_profile_edit' => 'signup#user_profile_edit'
      get 'congrats' => 'signup#congrats'
      post 'congrats' => 'signup#create', as: :signup_create
    end
  end

  resources :user do
    collection do
      get 'edit' => 'user#user-profile-edit'
      get 'destroy' => 'user#user-logout'
      get 'update' => 'user#user_ldentification'
    end
  end

  #他のブランチで作業していることがあるのでマージしてからresoucesに変えます。
  resources :mypage, only: [:new] do
    collection do
      get 'card' => 'cards#mypage_card'
      get 'card/create' => 'cards#new' # 新規登録ページに飛ぶ
      post 'card/create' => 'cards#create'
    end
  end

  resources :items, only: [:create] do 
    collection do
      get '/sell' => 'items#new'
      get '/search_children' => 'items#search_children'
      get '/search_grandchildren' => 'items#search_grandchildren'
      get '/search_shipping_charge' => 'items#search_shipping_methods'
      get '/get_size' => 'items#get_size'
    end
  end

  #他のブランチで作業していることがあるのでマージしてからresoucesに変えます。
  root to: 'home#index'
  get 'mypage' => 'home#mypage' # マイページ
  get ':id' => 'home#item_detail', as: :item_detail # 商品詳細
  get 'buy/:id' => 'home#buy', as: :buy # 購入内容の確認
  post 'buy/:id' => 'home#pay', as: :pay
  get 'buy/:id/done' => 'home#done', as: :done
  delete 'items/:id' => 'home#index', as: :item_delete # 削除
end