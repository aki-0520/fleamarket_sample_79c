class CreateDeliveryTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_types do |t|

      t.timestamps
    end
  end
end
