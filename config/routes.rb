Rails.application.routes.draw do
  root to: 'items#index'
  
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
      get 'congrats' => 'signup#congrats'
      post 'congrats' => 'signup#create', as: :signup_create
    end
  end

  resources :user do
    collection do
      get 'destroy' => 'user#user-logout'
      post 'tosaben' => 'user#tosaben'
    end
  end

  resources :mypage, only: [:index, :new] do
    collection do
      get 'identification' => 'user#edit'
      get 'profile' => 'user#profile'
      get 'card' => 'cards#mypage_card'
      get 'card/create' => 'cards#new' # 新規登録ページに飛ぶ
      post 'card/create' => 'cards#create'
    end
  end

  resources :items, only: [:create, :show, :edit, :update, :destroy] do 
    collection do
      get '/sell' => 'items#new'
      get '/search_children' => 'items#search_children'
      get '/search_grandchildren' => 'items#search_grandchildren'
      get '/search_shipping_charge' => 'items#search_shipping_methods'
      get '/get_size' => 'items#get_size'
      post '/upload_image' => 'items#upload_image'
    end
  end

  resources :purchase do
    get ':id' => 'purchase#buy', as: :buy # 購入内容の確認
    post ':id' => 'purchase#pay', as: :pay
    get ':id/done' => 'purchase#done', as: :done
  end
end