class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :code
      t.string :url
      t.decimal :price, precision: 10, scale: 2
      t.float :discount
      t.text :details
      t.integer :amount
      t.string :status

      t.timestamps
    end
  end
end
