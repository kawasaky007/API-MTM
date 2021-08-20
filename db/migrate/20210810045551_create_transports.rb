class CreateTransports < ActiveRecord::Migration[6.1]
  def change
    create_table :transports do |t|
      t.string :name
      t.string :region
      t.decimal :price
      t.string :transport_method

      t.timestamps
    end
  end
end
