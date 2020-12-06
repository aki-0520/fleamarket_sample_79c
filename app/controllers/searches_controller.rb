class SearchesController < ApplicationController
  before_action :set_ransack
  before_action :set_parents

  def index
    @search = params[:search]
    @searched_item = Item.search(params[:search]).limit(132)
    @searched_item_images_top = ItemImage.includes(:item).group(:item_id).where(item_id:@searched_item.ids)
    @parents = Category.where(ancestry: nil)
  end
  
  def detail_search
    @search_product = Item.ransack(params[:q]) 
    @products = @search_product.result.page(params[:page])
    @product_buyer_price_name_id = @products.pluck(:buyer_id,:price,:name,:id)
    @searched_item_images_top = ItemImage.includes(:item).group(:item_id).where(item_id:@products.ids).order(id: "DESC")
  end

private
  def set_ransack
    @q = Item.ransack(params[:q])
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end
end
