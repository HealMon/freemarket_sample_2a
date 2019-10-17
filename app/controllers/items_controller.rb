class ItemsController < ApplicationController
  before_action :set_item, only: :new

  def new
  end

  def create
    @item = Item.new(
      shipping_method: "123",
      trade_status: 1,
      condition: "123",
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

  private
  def set_item
    @item = Item.new
  end

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
                            images: []
                          )
  end
end
