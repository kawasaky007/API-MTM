class CreateFlashSaleDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :flash_sale_details do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :limit_per_user
      t.integer :total
      t.boolean :active

      t.timestamps
    end
  end
end
