class FixFlashSaleDetailIdName < ActiveRecord::Migration[6.1]
  def change
    rename_column :flash_sale_details, :flash_sale_detail_id, :flash_sale_id
  end
end
