class RemoveFlashSaleDetailsFromFlashSaleDetails < ActiveRecord::Migration[6.1]
  def change
    remove_column :flash_sale_details, :flash_sale_details, :integer
  end
end
