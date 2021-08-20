class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :full_name
      t.string :email
      t.string :phone_number
      t.string :province
      t.string :district
      t.references :transport, null: false, foreign_key: true
      t.string :payment_method
      t.decimal :price

      t.timestamps
    end
  end
end
