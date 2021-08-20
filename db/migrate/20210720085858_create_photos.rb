class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.references :photoable, polymorphic: true, null: false
      t.string :url

      t.timestamps
    end
  end
end
