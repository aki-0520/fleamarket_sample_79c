class AddSendFirstNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :send_first_name, :string
  end
end
