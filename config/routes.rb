Rails.application.routes.draw do
  root to: 'home#index'
  get 'mypage' => 'home#mypage' # マイページ
  get 'purchase' => 'home#purchase' # 商品購入ページ
end
