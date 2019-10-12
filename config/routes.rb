Rails.application.routes.draw do
  
  devise_for :users, skip: :all
  devise_scope :user do
    get 'signup' => 'devise/registrations#index', as: :new_user_information
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_registration
  end

  resources :signup do
    collection do
      get 'registration/' => 'signup#new'
      get 'sms_confirmation/' => 'signup#phone1'
      get 'sms_confirmation/sms' => 'signup#phone2'
      get 'address' => 'signup#address'
      get 'credit_card' => 'signup#payment'
      get 'congrats' => 'signup#congrats'
      post 'congrats' => 'signup#create'
    end
  end


  root to: 'home#index'
end
