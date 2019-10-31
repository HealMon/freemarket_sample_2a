class HomeController < ApplicationController
  before_action :set_item, only: [:item_detail, :buy, :done]
  before_action :set_card, only: [:buy, :done]

  def index
    @items_lady = Item.where(grand_category_id:1).order(id: "DESC").limit(10) # category指定を後で変更予定
    @items_men = Item.where(grand_category_id:2).order(id: "DESC").limit(10)
    @items_interia = Item.where(grand_category_id:3).order(id: "DESC").limit(10)
  end

  def mypage
  end

  def item_detail
  end

  def buy
  end

  def pay
    card = current_user.card
    
    if (current_user.id == Item.find(params[:id]).user_id) # 出品者と購入者が同じなら
      redirect_to mypage_path and return
    end

    if card.blank?
      redirect_to card_create_mypage_index_path # カード登録ページへ
    else 
      @item = Item.find(params[:id])
      # 購入した際の情報を元に引っ張ってくる
      Payjp.api_key = Rails.application.credentials[:secret_payjp_key]
      # キーをセットする
      Payjp::Charge.create(
      amount: @item.price, #支払金額
      customer: card.customer_id, #顧客ID
      currency: 'jpy', #日本円
      )
      # ↑商品の金額をamountへ、cardの顧客idをcustomerへ、currencyをjpyへ入れる
      if @item.update(trade_status: 2, buyer_id: current_user.id) #TODO: 出品者は自分の物は買えない
        redirect_to done_path(@item.id) # TODO: flashの追加
      else
        redirect_to item_detail_path
      end
      #↑この辺はこちら側のテーブル設計どうりに色々しています
    end
  end

  def done
    
  end

  
  private
  def set_item
    @item = Item.find(params[:id])
  end

  def set_card
    if current_user.card.blank?
      redirect_to card_create_mypage_index_path
    else
      require 'payjp'
      Payjp.api_key = Rails.application.credentials[:secret_payjp_key]
      card = Card.where(user_id: current_user.id)[0]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @card = customer.cards.retrieve(card.card_id)
    end
  end

end
