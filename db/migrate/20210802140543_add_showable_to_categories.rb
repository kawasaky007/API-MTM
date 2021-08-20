class AddShowableToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :showable, :boolean
  end
end
