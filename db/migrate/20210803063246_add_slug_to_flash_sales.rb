class AddSlugToFlashSales < ActiveRecord::Migration[6.1]
  def change
    add_column :flash_sales, :slug, :string
    add_index :flash_sales, :slug, unique: true
  end
end
