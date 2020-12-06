class AddSendFamilyNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :send_family_name, :string
  end
end
