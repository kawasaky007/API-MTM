class AddActiveToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :active, :boolean
    add_column :admins, :active, :boolean
  end
end
