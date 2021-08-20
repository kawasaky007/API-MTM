class AddSlugToBanners < ActiveRecord::Migration[6.1]
  def change
    add_column :banners, :slug, :string
    add_index :banners, :slug, unique: true
  end
end
