class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:destroy]

  def index
    @items_lady = Item.where(grand_category_id:1).order(id: "DESC").limit(10) # category指定を後で変更予定
    @items_men = Item.where(grand_category_id:2).order(id: "DESC").limit(10)
    @items_interia = Item.where(grand_category_id:3).order(id: "DESC").limit(10)
  end

  def new
    @item = current_user.items.build
    @parents = Category.all.order("id ASC").limit(3)
  end

  def create
    if current_user
      @item = current_user.items.build(
        trade_status: 1,
        shipping_method_id: item_params[:shipping_method_id],
        condition: item_params[:condition],
        grand_category_id: item_params[:category_id][0],
        parent_category_id: item_params[:category_id][1],
        category_id: item_params[:category_id][2],
        shipping_charge_id: item_params[:shipping_charge_id],
        estimated_delivery_id: item_params[:estimated_delivery_id],
        prefecture_id: item_params[:prefecture_id],
        name: item_params[:name],
        description: item_params[:description],
        price: item_params[:price],
        images: item_params[:images],
        products_sizes_id: item_params[:size_id].to_i 
      )
    end
    
    if @item.save
      redirect_to root_path
    else
      render 'items/new'
    end
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  def destroy
    if user_signed_in? && current_user.id == @item.user_id
      begin
        @item.destroy
        redirect_to root_path
      rescue => error
        puts error
      end
    end
  end
  
  def search_children
    respond_to do |format|
      format.html
      format.json do
        @children = Category.find(params[:parent_id]).children
        #親ボックスのidから子ボックスのidの配列を作成してインスタンス変数で定義
      end
    end
  end
  
  def search_grandchildren
    respond_to do |format|
      format.html
      format.json do
        @grandchildren = Category.find(params[:child_id]).children
      end
    end
  end

  def get_size
    respond_to do |format|
      format.html
      format.json do
        selected_child_category = Category.find("#{params[:grandchild_id]}").parent #子カテゴリーを取得
        if (selected_child_category.products_sizes != [])
          product_size = selected_child_category.products_sizes
          related_size_parent = ProductsSize.find(product_size.ids[0])
          @sizes = related_size_parent.children #紐づいたサイズ（親）の子供の配列を取得
        end
      end
    end
  end

  def search_shipping_methods
    respond_to do |format|
      format.html
      format.json do
        @shipping_methods = ShippingMethod.all
      end
    end
  end

  
  private
  def set_item
    @item = Item.find(params[:id])
    if user_signed_in? && current_user.id == @item.user_id
      @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def item_params
    params.require(:item).permit(
                            :name,
                            :description,
                            :price,
                            :condition,
                            :shipping_charge_id,
                            :shipping_method_id,
                            :prefecture_id,
                            :estimated_delivery_id,
                            :trade_status,
                            :size_id,
                            category_id: [],
                            images: []
                          )
  end
end


