Rails.application.routes.draw do
  
  devise_for :users, skip: :all
  devise_scope :user do
    get 'signup/registration/' => 'devise/registrations#new', as: :new_user_registration
    get 'signup' => 'devise/registrations#index', as: :new_user_information
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_registration
  end
  

  root to: 'home#index'
end
