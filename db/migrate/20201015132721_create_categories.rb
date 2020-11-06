class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.references :item, foreign_key: true
      t.timestamps
    end
  end
end