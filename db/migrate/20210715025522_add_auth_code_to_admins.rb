class AddAuthCodeToAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :auth_code, :string
  end
end
