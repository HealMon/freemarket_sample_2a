class ItemsController < ApplicationController
  def new
    @item = Item.new
    @parents = Category.all.order("id ASC").limit(3)
    # @child = Category.where(ancestry: '1/2').order("id ASC")
    # @grandchild = Category.where(ancestry: '1/3').order("id ASC")
  end

  def create
    @item = Item.new(
      shipping_method: "123",
      trade_status: 1,
      condition: "123",
      category_id: item_params[:category_id],
      shipping_charge_id: item_params[:shipping_charge_id],
      estimated_delivery_id: item_params[:estimated_delivery_id],
      prefecture_id: item_params[:prefecture_id],
      name: item_params[:name],
      description: item_params[:description],
      price: item_params[:price],
      images: item_params[:images]
    )

    if @item.save
      redirect_to root_path
    else
      render sell_items_path
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
  
  private
  def item_params
    params.require(:item).permit(
                            :name,
                            :description,
                            :price,
                            :condition,
                            :shipping_charge_id,
                            :shipping_method,
                            :prefecture_id,
                            :estimated_delivery_id,
                            :trade_status,
                            :category_id,
                            images: []
                          )
  end
end
