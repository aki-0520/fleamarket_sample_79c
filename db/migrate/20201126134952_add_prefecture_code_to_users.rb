class AddPrefectureCodeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :prefecture_code, :string
  end
end
