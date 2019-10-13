Rails.application.routes.draw do
  root to: 'home#index'
  get 'mypage' => 'home#mypage' # マイページ
end
