class AddPhotoToFlashSales < ActiveRecord::Migration[6.1]
  def change
    add_column :flash_sales, :photo, :string
  end
end
