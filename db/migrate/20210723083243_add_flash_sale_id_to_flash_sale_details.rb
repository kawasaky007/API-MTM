class AddFlashSaleIdToFlashSaleDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :flash_sale_details, :flash_sale_details, :integer
  end
end
