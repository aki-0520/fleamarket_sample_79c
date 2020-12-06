class AddPrefecturesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :prefectures, :string
  end
end
