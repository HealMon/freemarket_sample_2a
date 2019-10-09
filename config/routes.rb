Rails.application.routes.draw do
  
  devise_for :users, skip: :all
  devise_scope :user do
  #   get 'signup/registration/' => 'devise/registrations#new', as: :new_user_registration
    get 'signup' => 'devise/registrations#index', as: :new_user_information
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_registration
  end
  
  # # 仮置場
  # get 'signup/registration/phone1' => 'home#phone1'
  # get 'signup/registration/phone2' => 'home#phone2'
  # get 'signup/registration/address' => 'home#address'
  # get 'signup/registration/payment' => 'home#payment'
  # get 'signup/registration/congrats' => 'home#congrats'

  resources :signup do
    collection do
      # get 'signup/registration/' => 'devise/registrations#new', as: :new_user_registration
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


  root to: 'home#index'
end
