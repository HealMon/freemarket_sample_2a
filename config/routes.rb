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
      get 'congrats' => 'signup#congrats'
      get 'user_profile_edit' => 'signup#user_profile_edit'
      post 'congrats' => 'signup#create'
    end
  end

  get 'product_details' => 'home#products_details'


  resources :user do
    collection do
      get 'edit' => 'user#user-profile-edit'
      get 'destroy' => 'user#user-logout'
      get 'update' => 'user#user_ldentification'
    end
  end

  resources :credit_card, only: [:new]

  resources :items, only: [:create] do 
    collection do
      get '/sell' => 'items#new'
      get '/search_children' => 'items#search_children'
      get '/search_grandchildren' => 'items#search_grandchildren'
      get '/search_shipping_charge' => 'items#search_shipping_methods'
      get '/get_size' => 'items#get_size'
    end
  end


  root to: 'home#index'
  get 'mypage' => 'home#mypage' # マイページ
  
  get 'purchase' => 'home#purchase' # 商品購入ページ

  get 'mypage/card/' => 'home#mypage_card'

end