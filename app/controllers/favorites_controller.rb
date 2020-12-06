class FavoritesController < ApplicationController

  before_action :set_parents
  # before_action :set_category
  before_action :set_item, only: [:create,:destroy]
  before_action :authenticate_user!   # ログイン中のユーザーのみに許可（未ログインなら、ログイン画面へ移動）
  
  def index
    @favorites = Favorite.where(user_id: params[:user_id]).all
    @item = Favorite.find_by(item_id: params[:item_id], user_id: current_user.id)
  end

  def show
    @items_show = Item.where(id:params[:id])
    @user = Favorite.find_by(item_id: params[:item_id], user_id: current_user.id)
  end
  
  # お気に入り登録
  def create
    if current_user.id != @item.seller_id
    favorite = current_user.favorites.build(item_id: params[:item_id])
    # binding.pry
    favorite.save!
    end
  end

  # お気に入り削除
  def destroy 
    favorite = Favorite.find_by(item_id: params[:item_id], user_id: current_user.id)
    favorite.destroy
  end

  
  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  # def set_category
  #   @category = Category.find(params[:id])
  # end

  #お気に入り一覧表へのルーティングでparentsが引っかかるため記述
  def set_parents
    @parents = Category.where(ancestry: nil)
  end
 
end