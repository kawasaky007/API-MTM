class CreateFlashSales < ActiveRecord::Migration[6.1]
  def change
    create_table :flash_sales do |t|
      t.string :name
      t.datetime :active_time
      t.datetime :expired_time

      t.timestamps
    end
  end
end
