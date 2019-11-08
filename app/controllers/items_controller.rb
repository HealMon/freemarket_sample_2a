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

  def edit
    @item = Item.find(params[:id])
    @child_category = Category.find(@item.grand_category_id).children
    @grandgrchild_category = Category.find(@item.parent_category_id).children
    
    if @item.shipping_charge_id == 1
      @shipping_method = ShippingMethod.all
    else
      @shipping_method = ShippingMethod.first(4)
    end
  end

  def update
    @item = Item.find(params[:id])
    @child_category = Category.find(@item.grand_category_id).children
    @grandgrchild_category = Category.find(@item.parent_category_id).children

    if @item.shipping_charge_id == 1
      @shipping_method = ShippingMethod.all
    else
      @shipping_method = ShippingMethod.first(4)
    end
    
    @item.images.detach #一旦、すべてのimageの紐つけを解除
    if @item.user_id == current_user.id
      @item.update(
        shipping_method_id: params[:item][:shipping_method_id],
        condition: params[:item][:condition],
        grand_category_id: params[:item][:grand_category_id],
        parent_category_id: params[:item][:parent_category_id],
        category_id: params[:item][:category_id],
        shipping_charge_id: params[:item][:shipping_charge_id],
        estimated_delivery_id: params[:item][:estimated_delivery_id],
        prefecture_id: params[:item][:prefecture_id],
        name: params[:item][:name],
        description: params[:item][:description],
        price: params[:item][:price],
        products_sizes_id: params[:item][:size_id].to_i
      )

      @item.update(images: uploaded_images)
      if @item.valid?
        redirect_to item_path
      else
        render 'items/edit'
      end
    end
  end

  def show
    @item = Item.find(params[:id])
  end
  
  def destroy
    if user_signed_in? && current_user.id == @item.user_id
      if @item.destroy
        redirect_to root_path
      else
        redirect_to root_path
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

  def upload_image
    @image_blob = create_blob(params[:image])
    respond_to do |format|
      format.json { @image_blob }
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
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

  def uploaded_images
    params[:item][:images].map{|id| ActiveStorage::Blob.find(id)} if params[:item][:images]
  end

  def create_blob(uploading_file)
    ActiveStorage::Blob.create_after_upload! \
      io: uploading_file.open,
      filename: uploading_file.original_filename,
      content_type: uploading_file.content_type
  end
end