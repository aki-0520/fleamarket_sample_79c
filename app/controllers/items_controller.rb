class ItemsController < ApplicationController

  before_action :set_parents, only: [:new, :create]

  before_action :set_current_user_products,only:[:i_transaction,:i_exhibiting,:i_soldout]
  before_action :set_user,only:[:i_transaction,:i_exhibiting,:i_soldout]

  def index
    @items = Item.includes(:item_images).order('created_at DESC')
    @items = Item.all.where.not(trading_status:2)
    @item_images_top = ItemImage.all.includes(:item).group(:item_id)
  end

  def new
    @item = Item.new
    @item.item_images.new
    @address = Prefecture.all
  end

  def create
    @item = Item.new(item_params)
    # binding.pry
    if @item.save
      redirect_to root_path      
    else
      render :new
      # redirect_to new_item_path, data: { turbolinks: false }
    end
  end

  def edit
    @item = Item.new(item_params)
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  def search
    respond_to do |format|
      format.html
      format.json do
        #子カテゴリーを探して変数@childrensに代入します！
        @childrens = Category.find(params[:parent_id]).children
      end
    end
  end


  def p_exhibiting #出品中のアクション

  end

  def p_transaction  #取引中のアクション

  end

  def p_soldout    #売却済みのアクション

  end


  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :item_condition_id, :shipping_charge_players_id, :prefecture_code, :size, :preparation_day_id, :category_id, :brand, :delivery_type, item_images_attributes: [:src, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  # def set_current_user_items
  #   if user_signed_in? 
  #     @items = current_user.products.includes(:seller,:buyer,:item_images)
  #   else
  #     redirect_to new_user_session_path
  #   end
  # end
  
  # def set_user
  #   @user = User.find(current_user.id)
  # end
end

