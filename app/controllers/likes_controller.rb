class LikesController < ApplicationController
  before_action :set_items

  def like
    like = current_user.likes.new(item_id: @item.id)
    like.save
  end

  def unlike
    like = current_user.likes.find_by(item_id: @item.id)
    like.destroy
  end


  private

  def set_items
    @item = Item.find(params[:item_id])
    @id_name = "#like-link-#{@item.id}"
    @id_heart = "#heart-#{@item.id}"
  end
end
