class UsersController < ApplicationController
  def show
    @parents = Category.where(ancestry: nil)

    #以下お気に入り機能の実装
    @user = User.find(params[:id])
    @items = @user.items
    
    # favorites = Favorite.where(user_id: current_user.id).pluck(:item_id) # ログイン中のユーザーのお気に入りのitem_idカラムを取得
    # @favorite_list = Item.find(favorites) # itemsテーブルから、お気に入り登録済みのレコードを取得
  end

  def index
    @users = User.all
  end

  def new
    @address = Prefecture.all
  end

end
