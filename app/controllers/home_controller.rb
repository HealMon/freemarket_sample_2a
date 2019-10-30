class HomeController < ApplicationController
  def index
    @items_lady = Item.where(grand_category_id:1).order(id: "DESC").limit(10) # category指定を後で変更予定
    @items_men = Item.where(grand_category_id:2).order(id: "DESC").limit(10)
    @items_interia = Item.where(grand_category_id:3).order(id: "DESC").limit(10)
  end

  def mypage
  end
end
