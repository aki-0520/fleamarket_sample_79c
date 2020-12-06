class AddSendFamilyNameKanaToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :send_family_name_kana, :string
  end
end
