class HomeController < ApplicationController
  def index
    get_parents = Item.all.select("category_id").parents
      @items_lady = Item.all.where(category_id:25).order(id: "DESC").limit(10)
      @items_men = Item.all.where(category_id:2).order(id: "DESC").limit(10)
      @items_interia = Item.all.where(category_id:3).order(id: "DESC").limit(10)
  end


  def mypage
  end

  def products_details

  end
end
