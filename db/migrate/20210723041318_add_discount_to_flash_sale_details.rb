class AddDiscountToFlashSaleDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :flash_sale_details, :discount, :float
  end
end
