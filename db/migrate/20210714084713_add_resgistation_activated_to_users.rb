class AddResgistationActivatedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :resgistation_activated, :boolean
  end
end
