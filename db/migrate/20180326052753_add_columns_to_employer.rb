class AddColumnsToEmployer < ActiveRecord::Migration[5.0]
  def change
    add_column :employers, :password_token, :string
    add_column :employers, :pwd_link_expiry_date, :datetime
  end
end
