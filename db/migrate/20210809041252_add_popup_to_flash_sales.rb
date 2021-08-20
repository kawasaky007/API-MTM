class AddPopupToFlashSales < ActiveRecord::Migration[6.1]
  def change
    add_column :flash_sales, :popup, :boolean
  end
end
