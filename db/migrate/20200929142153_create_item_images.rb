class CreateItemImages < ActiveRecord::Migration[6.0]
  def change
    create_table :item_images do |t|
      t.string :url,null:false
      t.string :src,nul:false
      t.references :item,null: false, foreign_key: true
    end
  end
end
