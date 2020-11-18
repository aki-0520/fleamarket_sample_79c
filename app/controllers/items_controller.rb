class ItemsController < ApplicationController

  before_action :set_parents, only: [:index, :new, :create,:show,:edit,:update]
  before_action :set_category, only: [:show]
  before_action :set_current_user_products,only:[:i_transaction,:i_exhibiting,:i_soldout]
  before_action :set_user,only:[:i_transaction,:i_exhibiting,:i_soldout]

  def index
    @items = Item.all
    @item_images_top = ItemImage.includes(:item).group(:item_id)
    @item_images_top_last_five = @item_images_top.order(item_id: "DESC").limit(5)
    @items_last_five = @items.order(id: "DESC").limit(5)
  end

  def show
    @items_show = Item.where(id:params[:id])
    @item_images_detail = ItemImage.all.includes(:item).where(item_id:params[:id])
    @nickname = Item.find(params[:id]).seller.nickname
    @category_id = @items_show.pluck(:category_id)[0]
    @category_parent = Category.find(@category_id).parent.parent
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
  end

  def new
    @item = Item.new
    @item.item_images.new
    @address = Prefecture.all
  end

  def create
<<<<<<< Updated upstream
=======
    # binding.pry
>>>>>>> Stashed changes
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
    
  end

  def edit
    @item = Item.find(params[:id])
    @grandchild = @item.category
    @child = @grandchild.parent
    @parent  = @child.parent[:id]
    @children = Category.find(@parent).children
    @grandchildren = Category.find(@child[:id]).children
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
    # binding.pry
  end
  
  def get_category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end
  
  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
  
  def set_category
    @category = Category.find(params[:id])
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
    params.require(:item).permit(:name, :introduction, :price, :item_condition_id, :shipping_charge_players_id, :prefecture_code, :size_id,:seller_id, :preparation_day_id, :category_id, :brand_id, :delivery_type_id, item_images_attributes: [:src, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end

