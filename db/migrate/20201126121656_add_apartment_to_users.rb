class AddApartmentToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :apartment, :string
  end
end
