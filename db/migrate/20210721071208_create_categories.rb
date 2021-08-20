class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :icon
      t.string :photo
      t.string :association
      t.bigint :parent_id

      t.timestamps
    end
  end
end
