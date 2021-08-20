class AddFlashSaleDetailIdToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :flash_sale_detail_id, :integer
  end
end
