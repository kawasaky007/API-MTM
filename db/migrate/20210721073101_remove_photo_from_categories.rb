class RemovePhotoFromCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :categories, :photo, :string
  end
end
