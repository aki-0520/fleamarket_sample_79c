class AddSendFirstNameKanaToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :send_first_name_kana, :string
  end
end
