class AddFlashSaleToFlashSaleDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :flash_sale_details, :flash_sale_detail_id, :integer
  end
end
